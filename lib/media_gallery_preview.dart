import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:universal_html/html.dart' as html;
import 'package:http/http.dart' as http;

import 'youtube_helper.dart';

class MediaGalleryPreview extends StatefulWidget {
  final List<String> mediaUrls;

  const MediaGalleryPreview({super.key, required this.mediaUrls});

  @override
  State<MediaGalleryPreview> createState() => _MediaGalleryPreviewState();
}

class _MediaGalleryPreviewState extends State<MediaGalleryPreview> {
  late PageController _pageController;
  int _currentIndex = 0;
  final Map<int, YoutubePlayerController> _youtubeControllers = {};

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in _youtubeControllers.values) {
      controller.close();
    }
    _pageController.dispose();
    super.dispose();
  }

  YoutubePlayerController _getYouTubeController(String videoId, int index) {
    if (_youtubeControllers[index] != null) {
      return _youtubeControllers[index]!;
    }

    final controller = YoutubePlayerController(
      initialVideoId: videoId,
      params: const YoutubePlayerParams(
        autoPlay: false,
        showControls: true,
        showFullscreenButton: false,
        enableCaption: true,
        privacyEnhanced: true,
      ),
    );

    _youtubeControllers[index] = controller;
    return controller;
  }

  Future<void> downloadToGallery(String imageUrl, BuildContext context) async {
    try {
      // Check if we're on mobile
      if (kIsWeb) {
        // Web download handling
        final response = await http.get(Uri.parse(imageUrl));
        final blob = html.Blob([response.bodyBytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..setAttribute("download",
              "property_${DateTime.now().millisecondsSinceEpoch}.jpg")
          ..click();
        html.Url.revokeObjectUrl(url);
        return;
      }

      // Mobile platform handling
      final status = await _requestStoragePermission();
      if (!status) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Permission denied - cannot save image')),
        );
        return;
      }

      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode != 200) {
        throw Exception('Failed to download image');
      }

      // Save to gallery
      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.bodyBytes),
        quality: 100,
        name: "property_${DateTime.now().millisecondsSinceEpoch}",
      );

      if (result['isSuccess']) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Success'),
            content: const Text('Image saved'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        throw Exception('Failed to save image to gallery');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  Future<bool> _requestStoragePermission() async {
    if (!Platform.isAndroid && !Platform.isIOS) return false;

    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      final sdkInt = androidInfo.version.sdkInt ?? 0;

      if (sdkInt >= 33) {
        final status = await Permission.photos.request();
        return status.isGranted;
      } else {
        final status = await Permission.storage.request();
        return status.isGranted;
      }
    }

    // iOS only needs photos permission
    if (Platform.isIOS) {
      final status = await Permission.photos.request();
      return status.isGranted;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.mediaUrls.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final url = widget.mediaUrls[index];
              if (YouTubeHelper.isYouTubeUrl(url)) {
                final videoId = YouTubeHelper.extractVideoId(url);
                if (videoId != null) {
                  final controller = _getYouTubeController(videoId, index);
                  return Center(
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: YoutubePlayerIFrame(controller: controller),
                    ),
                  );
                }
              }
              return InteractiveViewer(
                child: Image.network(url, fit: BoxFit.contain),
              );
            },
          ),

          // Close button
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 28),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),

          // Download button for images
          if (!YouTubeHelper.isYouTubeUrl(widget.mediaUrls[_currentIndex]))
            Positioned(
              bottom: 40,
              right: 20,
              child: FloatingActionButton(
                backgroundColor: Colors.black54,
                onPressed: () =>
                    downloadToGallery(widget.mediaUrls[_currentIndex], context),
                child: const Icon(Icons.download, color: Colors.white),
              ),
            ),

          // Page indicator
          Positioned(
            bottom: 40,
            left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${_currentIndex + 1} / ${widget.mediaUrls.length}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}