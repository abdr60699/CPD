import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'media_gallery_preview.dart';
import 'youtube_helper.dart';

class PropertyCard extends StatefulWidget {
  final Map<String, dynamic> property;
  final VoidCallback onPhonePressed;
  final VoidCallback onWhatsAppPressed;
  final VoidCallback onMapPressed;
  final bool isMobile;

  const PropertyCard(
      {super.key,
      required this.property,
      required this.onPhonePressed,
      required this.onWhatsAppPressed,
      required this.onMapPressed,
      required this.isMobile});

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _expandAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildCarouselItem(String url) {
    Widget carouselContent;

    if (YouTubeHelper.isYouTubeUrl(url)) {
      final videoId = YouTubeHelper.extractVideoId(url);
      if (videoId != null) {
        carouselContent = Stack(
          children: [
            Image.network(
              YouTubeHelper.getThumbnailUrl(videoId),
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Center(child: Icon(Icons.broken_image)),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(12),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ],
        );
      } else {
        carouselContent = const Center(child: Icon(Icons.broken_image));
      }
    } else {
      // Regular image
      carouselContent = Image.network(
        url,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            const Center(child: Icon(Icons.broken_image)),
      );
    }

    // Wrap the carousel content with GestureDetector to make it tappable
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => MediaGalleryPreview(
            mediaUrls: List<String>.from(widget.property['images']),
          ),
        );
      },
      child: carouselContent,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;
    final isMediumScreen = screenWidth < 600;
    final titleFontSize = isSmallScreen ? 16.0 : (isMediumScreen ? 18.0 : 20.0);
    final locationFontSize =
        isSmallScreen ? 13.0 : (isMediumScreen ? 14.0 : 15.0);
    final priceFontSize = isSmallScreen ? 15.0 : (isMediumScreen ? 16.0 : 18.0);
    final detailFontSize =
        isSmallScreen ? 13.0 : (isMediumScreen ? 14.0 : 15.0);
    final buttonFontSize =
        isSmallScreen ? 12.0 : (isMediumScreen ? 13.0 : 14.0);
    final smallTextFontSize =
        isSmallScreen ? 12.0 : (isMediumScreen ? 13.0 : 14.0);
    final iconSize = isSmallScreen ? 16.0 : (isMediumScreen ? 18.0 : 20.0);
    final smallIconSize = isSmallScreen ? 14.0 : (isMediumScreen ? 16.0 : 18.0);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: SizedBox(
                height: 180,
                width: double.infinity,
                child: CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 1.0,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 4),
                    height: 180,
                  ),
                  items: (widget.property['images'] as List<String>)
                      .map((url) => _buildCarouselItem(url))
                      .toList(),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.property['title'],
                      style: TextStyle(fontSize: titleFontSize),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.location_on,
                            size: smallIconSize, color: Colors.grey),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            widget.property['location'],
                            style: TextStyle(
                                fontSize: locationFontSize, color: Colors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.property['forRent']
                          ? '₹${widget.property['rentAmount']}/month'
                          : '₹${(widget.property['price'] / 100000).toStringAsFixed(1)} Lakhs',
                      style: TextStyle(
                        fontSize: priceFontSize,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 12,
                      runSpacing: 6,
                      children: [
                        _buildPropertyDetail(
                            Icons.straighten,
                            '${widget.property['squareFeet']} sq.ft',
                            detailFontSize,
                            smallIconSize),
                        if (widget.property['bedrooms'] > 0)
                          _buildPropertyDetail(
                              Icons.bed,
                              '${widget.property['bedrooms']} BHK',
                              detailFontSize,
                              smallIconSize),
                      ],
                    ),
                    AnimatedBuilder(
                      animation: _expandAnimation,
                      builder: (context, child) {
                        return ClipRect(
                          child: Align(
                            alignment: Alignment.topCenter,
                            heightFactor: _expandAnimation.value,
                            child: child,
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Divider(height: 20),
                          if (widget.property['builtupArea'] > 0)
                            _buildDetailRow(
                                'Built-up Area',
                                '${widget.property['builtupArea']} sq.ft',
                                smallTextFontSize),
                          if (widget.property['grounds'] > 0)
                            _buildDetailRow(
                                'Grounds',
                                '${widget.property['grounds']}',
                                smallTextFontSize),
                          _buildDetailRow('Landmark',
                              widget.property['landmark'], smallTextFontSize),
                          if (widget.property['waterTax'] > 0)
                            _buildDetailRow(
                                'Water Tax',
                                '₹${widget.property['waterTax']} / year',
                                smallTextFontSize),
                          if (widget.property['propertyTax'] > 0)
                            _buildDetailRow(
                                'Property Tax',
                                '₹${widget.property['propertyTax']} / year',
                                smallTextFontSize),
                          if (widget.property['bathrooms'] > 0)
                            _buildDetailRow(
                                'Bathrooms',
                                '${widget.property['bathrooms']}',
                                smallTextFontSize),
                          if (widget.property['ageYears'] > 0)
                            _buildDetailRow(
                                'Building Age',
                                '${widget.property['ageYears']} years',
                                smallTextFontSize),
                          _buildDetailRow('Type', widget.property['type'],
                              smallTextFontSize),
                          _buildDetailRow('City', widget.property['city'],
                              smallTextFontSize),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: _toggleExpansion,
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: const EdgeInsets.symmetric(
                              vertical: 6,
                            ),
                          ),
                          child: Text(
                            _isExpanded
                                ? 'Show Less Details'
                                : 'Show More Details',
                            style: TextStyle(
                              fontSize: smallTextFontSize,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => MediaGalleryPreview(
                                mediaUrls: List<String>.from(
                                    widget.property['images']),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 8),
                          ),
                          icon: Icon(Icons.photo_library, size: smallIconSize),
                          label: Text('View All Media',
                              style: TextStyle(fontSize: smallTextFontSize)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        SizedBox(
                          width: 80, // Slightly reduced width for Map button
                          child: ElevatedButton.icon(
                            onPressed: widget.onMapPressed,
                            icon: Icon(Icons.location_on, size: smallIconSize),
                            label: Text(
                              'Map',
                              style: TextStyle(fontSize: buttonFontSize),
                            ),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: widget.onPhonePressed,
                            icon: Icon(Icons.phone, size: smallIconSize),
                            label: Text(
                              'Phone',
                              style: TextStyle(fontSize: buttonFontSize),
                            ),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: widget.onWhatsAppPressed,
                            icon: Icon(FontAwesomeIcons.whatsapp,
                                size: smallIconSize),
                            label: Text(
                              'WhatsApp',
                              style: TextStyle(fontSize: buttonFontSize),
                            ),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyDetail(
      IconData icon, String text, double fontSize, double iconSize) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: iconSize, color: Colors.grey),
        const SizedBox(width: 6),
        Text(text, style: TextStyle(fontSize: fontSize)),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, double fontSize) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              '$label:',
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: fontSize),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}