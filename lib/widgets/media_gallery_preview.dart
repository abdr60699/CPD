import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:universal_html/html.dart' as html;
import 'package:http/http.dart' as http;

import '../models/youtube_helper.dart';

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
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    // Properly dispose all YouTube controllers
    for (var controller in _youtubeControllers.values) {
      controller.close();
    }
    _youtubeControllers.clear();
    _pageController.dispose();
    super.dispose();
  }

  YoutubePlayerController _getYouTubeController(String videoId, int index) {
    if (_youtubeControllers[index] != null) {
      return _youtubeControllers[index]!;
    }

    try {
      final controller = YoutubePlayerController(
        initialVideoId: videoId,
        params: const YoutubePlayerParams(
          autoPlay: true, // Changed to true for better UX
          showControls: true,
          showFullscreenButton: true,
          enableCaption: false, // Disable to reduce loading issues
          privacyEnhanced: false, // Disable to reduce loading issues
          playsInline: true, // Keep inline for better mobile experience
          mute: false,
          loop: false,
          enableJavaScript: true,
        ),
      );

      _youtubeControllers[index] = controller;
      return controller;
    } catch (e) {
      print('Error creating YouTube controller: $e');
      rethrow; // Re-throw to be caught by the calling method
    }
  }

  // Handle controller cleanup when page changes
  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Don't pause other videos - let user control playback
    // The previous approach of pausing other videos was causing issues
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

  Widget _buildMediaItem(int index) {
    final url = widget.mediaUrls[index];

    if (YouTubeHelper.isYouTubeUrl(url)) {
      final videoId = YouTubeHelper.extractVideoId(url);
      if (videoId != null) {
        try {
          final controller = _getYouTubeController(videoId, index);

          return Container(
            color: Colors.black,
            child: Center(
              child: YoutubePlayerIFrame(
                controller: controller,
              ),
            ),
          );
        } catch (e) {
          print('Error creating YouTube player: $e');
          // Fallback to show thumbnail with external link option
          return Container(
            color: Colors.black,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    YouTubeHelper.getThumbnailUrl(videoId),
                    width: 300,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.video_library,
                      color: Colors.white70,
                      size: 48,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'YouTube Player Not Available',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      // You can add url_launcher here to open in browser
                      print('Open YouTube URL: $url');
                    },
                    icon: const Icon(Icons.open_in_browser),
                    label: const Text('Open in Browser'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      } else {
        // Invalid YouTube URL
        return const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, color: Colors.white70, size: 48),
              SizedBox(height: 16),
              Text(
                'Invalid YouTube URL',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ],
          ),
        );
      }
    } else {
      // Regular image
      return InteractiveViewer(
        child: Image.network(
          url,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Loading image...',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.broken_image, color: Colors.white70, size: 48),
                  SizedBox(height: 16),
                  Text(
                    'Failed to load image',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Handle empty media case
    if (widget.mediaUrls.isEmpty) {
      return Dialog(
        backgroundColor: Colors.black,
        insetPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.photo_library, color: Colors.white70, size: 48),
              const SizedBox(height: 16),
              const Text(
                'No photos or videos available',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Close',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Dialog(
      backgroundColor: Colors.black,
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.mediaUrls.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) => _buildMediaItem(index),
          ),

          // Only show navigation controls if we have more than 1 item
          if (widget.mediaUrls.length > 1) ...[
            // Backward button
            Positioned(
              left: 10,
              top: MediaQuery.of(context).size.height / 2 - 24,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios,
                    color: Colors.white, size: 32),
                onPressed: () {
                  if (_currentIndex > 0) {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
            ),

            // Forward button
            Positioned(
              right: 10,
              top: MediaQuery.of(context).size.height / 2 - 24,
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios,
                    color: Colors.white, size: 32),
                onPressed: () {
                  if (_currentIndex < widget.mediaUrls.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
            ),

            // Page indicator
            Positioned(
              bottom: 40,
              left: 20,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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

          // Close button
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 28),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),

          // Download button for images (only show if current item is not a YouTube video)
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

          // Video indicator for YouTube videos
          if (YouTubeHelper.isYouTubeUrl(widget.mediaUrls[_currentIndex]))
            Positioned(
              bottom: 100,
              right: 20,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.play_arrow, color: Colors.white, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'YouTube Video',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
