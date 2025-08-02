import 'dart:io';

import 'package:checkdreamproperty/models/youtube_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddPropertyDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onPropertyAdded;
  final Map<String, dynamic>? existingProperty;
  final List<Map<String, dynamic>> properties;

  const AddPropertyDialog({
    super.key,
    required this.onPropertyAdded,
    this.existingProperty,
    required this.properties,
  });

  @override
  State<AddPropertyDialog> createState() => _AddPropertyDialogState();
}

class _AddPropertyDialogState extends State<AddPropertyDialog> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  // Form controllers
  final _headerController = TextEditingController();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _squareFeetController = TextEditingController();
  final _groundsController = TextEditingController();
  final _builtupAreaController = TextEditingController();
  final _mapLinkController = TextEditingController();
  final _waterTaxController = TextEditingController();
  final _propertyTaxController = TextEditingController();
  final _bedroomsController = TextEditingController();
  final _bathroomsController = TextEditingController();
  final _ageYearsController = TextEditingController();
  final _rentAmountController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _cityController = TextEditingController();
  final _locationController = TextEditingController();

  // Form values
  String _selectedType = 'Apartment';
  String _selectedLocation = 'Velachery';
  String _selectedCity = 'Chennai';
  bool _forRent = false;
  List<String> _imageUrls = [];
  List<String> _phoneNumbers = [''];
  List<String> _landmarks = [''];
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;

  final List<String> _propertyTypes = [
    'Apartment',
    'Villa',
    'Plot',
    'Commercial'
  ];

  @override
  void initState() {
    super.initState();
    if (widget.existingProperty != null) {
      _populateExistingData();
    }
  }

  void _populateExistingData() {
    final property = widget.existingProperty!;
    _headerController.text = property['header'] ?? '';
    _titleController.text = property['title'] ?? '';
    _selectedType = property['type'] ?? 'Apartment';
    _selectedLocation = property['location'] ?? 'Velachery';
    _selectedCity = property['city'] ?? 'Chennai';
    _priceController.text = property['price']?.toString() ?? '';
    _squareFeetController.text = property['squareFeet']?.toString() ?? '';
    _groundsController.text = property['grounds']?.toString() ?? '';
    _builtupAreaController.text = property['builtupArea']?.toString() ?? '';
    _mapLinkController.text = property['mapLink'] ?? '';
    _waterTaxController.text = property['waterTax']?.toString() ?? '';
    _propertyTaxController.text = property['propertyTax']?.toString() ?? '';
    _bedroomsController.text = property['bedrooms']?.toString() ?? '';
    _bathroomsController.text = property['bathrooms']?.toString() ?? '';
    _ageYearsController.text = property['ageYears']?.toString() ?? '';
    _forRent = property['forRent'] ?? false;
    _rentAmountController.text = property['rentAmount']?.toString() ?? '';
    _whatsappController.text = property['contact']?['whatsapp'] ?? '';
    _imageUrls = List<String>.from(property['images'] ?? []);

    // Handle multiple phone numbers
    if (property['contact']?['phoneNumbers'] != null) {
      _phoneNumbers = List<String>.from(property['contact']['phoneNumbers']);
    } else if (property['contact']?['phone'] != null) {
      _phoneNumbers = [property['contact']['phone']];
    }

    // Handle multiple landmarks
    if (property['landmarks'] != null) {
      _landmarks = List<String>.from(property['landmarks']);
    } else if (property['landmark'] != null) {
      _landmarks = [property['landmark']];
    }

    final existingImages = List<String>.from(property['images'] ?? []);
    _imageUrls = List<String>.from(existingImages);
    _localImageFiles =
        List.generate(existingImages.length, (index) => File(''));
    _isImageUploaded = List.generate(existingImages.length, (index) => true);
  }

  @override
  void dispose() {
    _headerController.dispose();
    _titleController.dispose();
    _priceController.dispose();
    _squareFeetController.dispose();
    _groundsController.dispose();
    _builtupAreaController.dispose();
    _mapLinkController.dispose();
    _waterTaxController.dispose();
    _propertyTaxController.dispose();
    _bedroomsController.dispose();
    _bathroomsController.dispose();
    _ageYearsController.dispose();
    _rentAmountController.dispose();
    _whatsappController.dispose();
    _imageUrlController.dispose();
    _scrollController.dispose();
    _cityController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  List<File> _localImageFiles =
      []; // Add this to store local files before upload
  List<bool> _isImageUploaded = [];

  Future<String?> _uploadImage(File imageFile) async {
    try {
      // Check if file exists
      if (!await imageFile.exists()) {
        print('Image file does not exist');
        return null;
      }

      // Compress image before upload
      final compressedFile = await _compressImage(imageFile);
      if (compressedFile == null) {
        print('Failed to compress image');
        return null;
      }

      // Generate unique filename
      final fileExtension = path.extension(compressedFile.path).toLowerCase();
      final fileName =
          'property_${DateTime.now().millisecondsSinceEpoch}$fileExtension';
      final filePath = 'property_images/$fileName';

      print('Uploading compressed image: $fileName');
      print('Original size: ${await imageFile.length()} bytes');
      print('Compressed size: ${await compressedFile.length()} bytes');

      // Upload compressed file using file path
      final response =
          await Supabase.instance.client.storage.from('property-images').upload(
                filePath, compressedFile, // Send File object directly
                fileOptions: FileOptions(
                  contentType: _getContentType(fileExtension),
                  upsert: false,
                ),
              );

      print('Upload response: $response');

      // Clean up compressed file if it's different from original
      if (compressedFile.path != imageFile.path) {
        await compressedFile.delete();
      }

      // Get public URL
      final imageUrl = Supabase.instance.client.storage
          .from('property-images')
          .getPublicUrl(filePath);

      return imageUrl;
    } catch (e) {
      // More specific error handling
      if (e.toString().contains('The resource already exists')) {
        print('File already exists, generating new name...');
        // Retry with a different name
        return _uploadImageWithRetry(imageFile);
      } else if (e.toString().contains('Bucket not found')) {
        print(
            'Storage bucket "property-images" not found. Please create it in Supabase dashboard.');
        return null;
      } else if (e.toString().contains('Insufficient permissions')) {
        print('Permission denied. Please check your RLS policies.');
        return null;
      }

      return null;
    }
  }

// Add this new method for image compression:
  Future<File?> _compressImage(File originalFile) async {
    try {
      // Get temporary directory
      final tempDir = await getTemporaryDirectory();
      final targetPath = path.join(tempDir.path,
          'compressed_${DateTime.now().millisecondsSinceEpoch}.jpg');

      // Get original file size
      final originalSize = await originalFile.length();

      // Skip compression if file is already small (less than 500KB)
      if (originalSize < 500 * 1024) {
        return originalFile;
      }

      // Compress image
      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        originalFile.absolute.path,
        targetPath,
        quality: 80, // Adjust quality (0-100)
        minWidth: 1920, // Maximum width
        minHeight: 1080, // Maximum height
        format: CompressFormat.jpeg,
      );

      if (compressedFile != null) {
        final compressedSize = await File(compressedFile.path).length();
        print('Compression: $originalSize bytes -> $compressedSize bytes');
        print(
            'Compression ratio: ${(compressedSize / originalSize * 100).toStringAsFixed(1)}%');

        return File(compressedFile.path);
      }

      return originalFile; // Return original if compression failed
    } catch (e) {
      print('Error compressing image: $e');
      return originalFile; // Return original if compression failed
    }
  }

// Add this helper method:
  String _getContentType(String fileExtension) {
    switch (fileExtension.toLowerCase()) {
      case '.jpg':
      case '.jpeg':
        return 'image/jpeg';
      case '.png':
        return 'image/png';
      case '.webp':
        return 'image/webp';
      case '.gif':
        return 'image/gif';
      default:
        return 'image/jpeg';
    }
  }

// Add this retry method:
  Future<String?> _uploadImageWithRetry(File imageFile,
      [int retryCount = 0]) async {
    if (retryCount >= 3) {
      print('Max retry attempts reached');
      return null;
    }

    try {
      // Wait a bit before retry
      await Future.delayed(Duration(milliseconds: 500 * (retryCount + 1)));

      // Compress image
      final compressedFile = await _compressImage(imageFile);
      if (compressedFile == null) {
        return null;
      }

      // Generate unique filename with timestamp and random number
      final fileExtension = path.extension(compressedFile.path).toLowerCase();
      final fileName =
          'property_${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().microsecond}$fileExtension';
      final filePath = 'property_images/$fileName';

      print('Retry upload attempt ${retryCount + 1}: $fileName');

      // Upload compressed file
      final response =
          await Supabase.instance.client.storage.from('property-images').upload(
                filePath,
                compressedFile,
                fileOptions: FileOptions(
                  contentType: _getContentType(fileExtension),
                  upsert: false,
                ),
              );

      // Clean up compressed file if different from original
      if (compressedFile.path != imageFile.path) {
        await compressedFile.delete();
      }

      // Get public URL
      final imageUrl = Supabase.instance.client.storage
          .from('property-images')
          .getPublicUrl(filePath);

      return imageUrl;
    } catch (e) {
      if (e.toString().contains('The resource already exists')) {
        // Retry with different name
        return _uploadImageWithRetry(imageFile, retryCount + 1);
      }
      print('Retry failed: $e');
      return null;
    }
  }

// Updated _pickImageFile method with better compression options:
  Future<void> _pickImageFile(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 2048, // Increased for better quality before compression
        maxHeight: 2048,
        imageQuality: 90, // Higher quality since we'll compress later
      );

      if (image != null) {
        final File imageFile = File(image.path);

        // Check if file exists
        if (!await imageFile.exists()) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Selected image file not found')),
            );
          }
          return;
        }

        // Check file size (limit to 10MB before compression)
        final fileSize = await imageFile.length();
        if (fileSize > 10 * 1024 * 1024) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Image size should be less than 10MB')),
            );
          }
          return;
        }

        // Check file type
        final String fileExtension = path.extension(image.path).toLowerCase();
        if (!['.jpg', '.jpeg', '.png', '.webp'].contains(fileExtension)) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'Please select a valid image file (JPG, PNG, WebP)')),
            );
          }
          return;
        }

        // Add local file to list immediately for preview
        setState(() {
          _localImageFiles.add(imageFile);
          _imageUrls.add(''); // Placeholder for URL
          _isImageUploaded.add(false); // Mark as not uploaded yet
        });

        // Upload in background
        _uploadImageInBackground(_localImageFiles.length - 1);
      }
    } catch (e) {
      print('Error picking image: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking image: $e')),
        );
      }
    }
  }

// Updated background upload method:
  Future<void> _uploadImageInBackground(int index) async {
    try {
      setState(() {
        _isUploading = true;
      });

      String? imageUrl = await _uploadImage(_localImageFiles[index]);

      if (imageUrl != null && imageUrl.isNotEmpty) {
        setState(() {
          _imageUrls[index] = imageUrl;
          _isImageUploaded[index] = true;
          _isUploading = false;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Image compressed and uploaded successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        // Remove the failed upload from lists
        setState(() {
          _imageUrls.removeAt(index);
          _localImageFiles.removeAt(index);
          _isImageUploaded.removeAt(index);
          _isUploading = false;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to upload image. Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      print('Error in background upload: $e');

      // Remove the failed upload from lists
      setState(() {
        if (index < _imageUrls.length) {
          _imageUrls.removeAt(index);
          _localImageFiles.removeAt(index);
          _isImageUploaded.removeAt(index);
        }
        _isUploading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error uploading image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _addImageUrl() {
    if (_imageUrlController.text.isNotEmpty) {
      setState(() {
        _imageUrls.add(_imageUrlController.text);
        _localImageFiles.add(File('')); // Empty file for URL-based images
        _isImageUploaded.add(true); // URL images are considered "uploaded"
        _imageUrlController.clear();
      });
    }
  }

// Updated _removeImageUrl method
  void _removeImageUrl(int index) {
    setState(() {
      _imageUrls.removeAt(index);
      _localImageFiles.removeAt(index);
      _isImageUploaded.removeAt(index);
    });
  }

// // Updated image preview widget
//   Widget _buildImageUploadSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: _buildTextField(
//                 controller: _imageUrlController,
//                 label: 'Image URL',
//                 hint: 'https://example.com/image.jpg',
//                 prefixIcon: Icons.link,
//               ),
//             ),
//             const SizedBox(width: 8),
//             IconButton(
//               onPressed: _addImageUrl,
//               icon:
//                   Icon(Icons.add_circle, color: Theme.of(context).primaryColor),
//               iconSize: 22,
//             ),
//           ],
//         ),

//         if (_isUploading)
//           const Padding(
//             padding: EdgeInsets.symmetric(vertical: 16),
//             child: Center(
//               child: Column(
//                 children: [
//                   CircularProgressIndicator(),
//                   SizedBox(height: 8),
//                   Text('Uploading image...'),
//                 ],
//               ),
//             ),
//           ),

//         const SizedBox(height: 12),

//         // Updated image preview with local file support
//         if (_imageUrls.isNotEmpty)
//           SizedBox(
//             height: 100,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: _imageUrls.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   margin: const EdgeInsets.only(right: 8),
//                   child: Stack(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: _buildImageWidget(index),
//                       ),

//                       // Upload status indicator
//                       if (!_isImageUploaded[index])
//                         Positioned(
//                           top: 4,
//                           left: 4,
//                           child: Container(
//                             padding: const EdgeInsets.all(4),
//                             decoration: BoxDecoration(
//                               color: Colors.orange,
//                               borderRadius: BorderRadius.circular(4),
//                             ),
//                             child: const Icon(
//                               Icons.cloud_upload,
//                               color: Colors.white,
//                               size: 16,
//                             ),
//                           ),
//                         ),

//                       // Remove button
//                       Positioned(
//                         top: 4,
//                         right: 4,
//                         child: GestureDetector(
//                           onTap: () => _removeImageUrl(index),
//                           child: Container(
//                             decoration: const BoxDecoration(
//                               color: Colors.red,
//                               shape: BoxShape.circle,
//                             ),
//                             child: const Icon(
//                               Icons.close,
//                               color: Colors.white,
//                               size: 20,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         const SizedBox(height: 8),
//         // Upload buttons row
//         Row(
//           children: [
//             Expanded(
//               child: OutlinedButton.icon(
//                 onPressed: _isUploading
//                     ? null
//                     : () => _pickImageFile(ImageSource.gallery),
//                 icon: const Icon(Icons.photo_library),
//                 label: const Text('Upload'),
//                 style: OutlinedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 8),
//             Expanded(
//               child: OutlinedButton.icon(
//                 onPressed: _isUploading
//                     ? null
//                     : () => _pickImageFile(ImageSource.camera),
//                 icon: const Icon(Icons.camera_alt),
//                 label: const Text('Camera'),
//                 style: OutlinedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildImageWidget(int index) {
//     const double imageSize = 100;

//     // If it's a local file (not uploaded yet), show from file
//     if (!_isImageUploaded[index] && _localImageFiles[index].path.isNotEmpty) {
//       return Image.file(
//         _localImageFiles[index],
//         width: imageSize,
//         height: imageSize,
//         fit: BoxFit.cover,
//         errorBuilder: (context, error, stackTrace) {
//           return Container(
//             width: imageSize,
//             height: imageSize,
//             color: Colors.grey[300],
//             child: const Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.error, color: Colors.red),
//                   Text("Error", style: TextStyle(fontSize: 12)),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     }

//     // If it's uploaded or a URL, show from network
//     if (_imageUrls[index].isNotEmpty) {
//       return Image.network(
//         _imageUrls[index],
//         width: imageSize,
//         height: imageSize,
//         fit: BoxFit.cover,
//         loadingBuilder: (context, child, loadingProgress) {
//           if (loadingProgress == null) return child;
//           return Container(
//             width: imageSize,
//             height: imageSize,
//             color: Colors.grey[300],
//             child: Center(
//               child: CircularProgressIndicator(
//                 value: loadingProgress.expectedTotalBytes != null
//                     ? loadingProgress.cumulativeBytesLoaded /
//                         loadingProgress.expectedTotalBytes!
//                     : null,
//               ),
//             ),
//           );
//         },
//         errorBuilder: (context, error, stackTrace) {
//           return Container(
//             width: imageSize,
//             height: imageSize,
//             color: Colors.grey[300],
//             child: const Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.error, color: Colors.red),
//                   Text("Error", style: TextStyle(fontSize: 12)),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     }

//     // Fallback
//     return Container(
//       width: imageSize,
//       height: imageSize,
//       color: Colors.grey[300],
//       child: const Center(
//         child: Icon(Icons.image, color: Colors.grey),
//       ),
//     );
//   }




// Replace the _buildImageWidget method in AddPropertyDialog:
Widget _buildImageWidget(int index) {
  const double imageSize = 100;

  // If it's a local file (not uploaded yet), show from file
  if (!_isImageUploaded[index] && _localImageFiles[index].path.isNotEmpty) {
    return Image.file(
      _localImageFiles[index],
      width: imageSize,
      height: imageSize,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: imageSize,
          height: imageSize,
          color: Colors.grey[300],
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.red),
                Text("Error", style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        );
      },
    );
  }

  // If it's uploaded or a URL, show from network
  if (_imageUrls[index].isNotEmpty) {
    final url = _imageUrls[index];
    
    // Check if it's a YouTube URL
    if (YouTubeHelper.isYouTubeUrl(url)) {
      final videoId = YouTubeHelper.extractVideoId(url);
      if (videoId != null) {
        return Stack(
          children: [
            Image.network(
              YouTubeHelper.getThumbnailUrl(videoId),
              width: imageSize,
              height: imageSize,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: imageSize,
                  height: imageSize,
                  color: Colors.grey[300],
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: imageSize,
                  height: imageSize,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, color: Colors.red),
                        Text("Error", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                );
              },
            ),
            // YouTube play button overlay
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ],
        );
      }
    }

    // Regular image
    return Image.network(
      url,
      width: imageSize,
      height: imageSize,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          width: imageSize,
          height: imageSize,
          color: Colors.grey[300],
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: imageSize,
          height: imageSize,
          color: Colors.grey[300],
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.red),
                Text("Error", style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        );
      },
    );
  }

  // Fallback
  return Container(
    width: imageSize,
    height: imageSize,
    color: Colors.grey[300],
    child: const Center(
      child: Icon(Icons.image, color: Colors.grey),
    ),
  );
}

// Replace the _buildImageUploadSection method in AddPropertyDialog:
Widget _buildImageUploadSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Expanded(
            child: _buildTextField(
              controller: _imageUrlController,
              label: 'Image/Video URL',
              hint: 'https://example.com/image.jpg or YouTube URL',
              prefixIcon: Icons.link,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: _addImageUrl,
            icon:
                Icon(Icons.add_circle, color: Theme.of(context).primaryColor),
            iconSize: 22,
          ),
        ],
      ),

      if (_isUploading)
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: Column(
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 8),
                Text('Uploading image...'),
              ],
            ),
          ),
        ),

      const SizedBox(height: 12),

      // Updated image preview with YouTube support
      if (_imageUrls.isNotEmpty)
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _imageUrls.length,
            itemBuilder: (context, index) {
              final isYouTube = YouTubeHelper.isYouTubeUrl(_imageUrls[index]);
              
              return Container(
                margin: const EdgeInsets.only(right: 8),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: _buildImageWidget(index),
                    ),

                    // YouTube indicator
                    if (isYouTube)
                      Positioned(
                        bottom: 4,
                        left: 4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'VIDEO',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                    // Upload status indicator
                    if (!_isImageUploaded[index])
                      Positioned(
                        top: 4,
                        left: 4,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(
                            Icons.cloud_upload,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),

                    // Remove button
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () => _removeImageUrl(index),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      const SizedBox(height: 8),
      // Upload buttons row
      Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _isUploading
                  ? null
                  : () => _pickImageFile(ImageSource.gallery),
              icon: const Icon(Icons.photo_library),
              label: const Text('Upload'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _isUploading
                  ? null
                  : () => _pickImageFile(ImageSource.camera),
              icon: const Icon(Icons.camera_alt),
              label: const Text('Camera'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Text(
        'Note: You can add images, YouTube videos, or other media URLs',
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
          fontStyle: FontStyle.italic,
        ),
      ),
    ],
  );
}

  void _addPhoneNumber() {
    setState(() {
      _phoneNumbers.add('');
    });
  }

  void _removePhoneNumber(int index) {
    if (_phoneNumbers.length > 1) {
      setState(() {
        _phoneNumbers.removeAt(index);
      });
    }
  }

  void _addLandmark() {
    setState(() {
      _landmarks.add('');
    });
  }

  void _removeLandmark(int index) {
    if (_landmarks.length > 1) {
      setState(() {
        _landmarks.removeAt(index);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final validPhoneNumbers =
          _phoneNumbers.where((phone) => phone.trim().isNotEmpty).map((phone) {
        String cleanPhone = phone.trim();
        // Ensure it's a 10-digit number and add +91 prefix
        if (cleanPhone.length == 10 &&
            RegExp(r'^[6-9][0-9]{9}$').hasMatch(cleanPhone)) {
          return '+91$cleanPhone';
        }
        return cleanPhone.startsWith('+91') ? cleanPhone : '+91$cleanPhone';
      }).toList();

      final finalImageUrls = <String>[];
      for (int i = 0; i < _imageUrls.length; i++) {
        if (_isImageUploaded[i] && _imageUrls[i].isNotEmpty) {
          finalImageUrls.add(_imageUrls[i]);
        }
      }

      final validLandmarks =
          _landmarks.where((landmark) => landmark.trim().isNotEmpty).toList();

      // Process WhatsApp number - ensure it's 10 digits and add +91
      String whatsappNumber = _whatsappController.text.trim();
      if (whatsappNumber.isNotEmpty) {
        if (whatsappNumber.length == 10 &&
            RegExp(r'^[6-9][0-9]{9}$').hasMatch(whatsappNumber)) {
          whatsappNumber = '+91$whatsappNumber';
        } else if (!whatsappNumber.startsWith('+91')) {
          whatsappNumber = '+91$whatsappNumber';
        }
      }

      final propertyData = {
        'header': _headerController.text,
        'title': _titleController.text,
        'type': _selectedType,
        'location': _locationController.text.isNotEmpty
            ? _locationController.text.trim()
            : _selectedLocation,
        'city': _cityController.text.isNotEmpty
            ? _cityController.text.trim()
            : _selectedCity,
        'price': double.tryParse(_priceController.text) ?? 0,
        'squareFeet': double.tryParse(_squareFeetController.text) ?? 0,
        'grounds': double.tryParse(_groundsController.text) ?? 0,
        'builtupArea': double.tryParse(_builtupAreaController.text) ?? 0,
        'landmarks': validLandmarks,
        'mapLink': _mapLinkController.text.trim(),
        'waterTax': double.tryParse(_waterTaxController.text) ?? 0,
        'propertyTax': double.tryParse(_propertyTaxController.text) ?? 0,
        'bedrooms': int.tryParse(_bedroomsController.text) ?? 0,
        'bathrooms': int.tryParse(_bathroomsController.text) ?? 0,
        'ageYears': int.tryParse(_ageYearsController.text) ?? 0,
        'forRent': _forRent,
        'rentAmount': double.tryParse(_rentAmountController.text) ?? 0,
        'images': finalImageUrls,
        'contact': {
          // 'phoneNumbers': validPhoneNumbers,
          'phone': validPhoneNumbers.isNotEmpty ? validPhoneNumbers.first : '',
          'whatsapp': whatsappNumber,
        }
      };

      widget.onPropertyAdded(propertyData);
      Navigator.of(context).pop();
    }
  }

  String _formatIndianNumber(String numberStr) {
    if (numberStr.isEmpty) return '';

    try {
      int number = int.parse(numberStr);

      if (number >= 10000000) {
        // 1 crore and above
        double crores = number / 10000000;
        return crores == crores.toInt()
            ? '${crores.toInt()} crore'
            : '${crores.toStringAsFixed(2)} crore';
      } else if (number >= 100000) {
        // 1 lakh and above
        double lakhs = number / 100000;
        return lakhs == lakhs.toInt()
            ? '${lakhs.toInt()} lac'
            : '${lakhs.toStringAsFixed(2)} lac';
      } else if (number >= 1000) {
        // 1 thousand and above
        double thousands = number / 1000;
        return thousands == thousands.toInt()
            ? '${thousands.toInt()} thousand'
            : '${thousands.toStringAsFixed(2)} thousand';
      } else {
        return number.toString();
      }
    } catch (e) {
      return '';
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    IconData? prefixIcon,
    void Function(String)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        style: GoogleFonts.poppins(fontSize: 14),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 20) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildMultiplePhoneNumbers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Numbers',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        ...List.generate(_phoneNumbers.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: _phoneNumbers[index],
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    onChanged: (value) => _phoneNumbers[index] = value,
                    validator: (value) {
                      if (index == 0 && (value?.isEmpty == true)) {
                        return 'At least one phone number is required';
                      }
                      if (value != null && value.isNotEmpty) {
                        if (value.length != 10) {
                          return 'Enter 10-digit number';
                        }
                        if (!RegExp(r'^[6-9][0-9]{9}$').hasMatch(value)) {
                          return 'Invalid Indian mobile number';
                        }
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: '9876543210',
                      prefixIcon: const Icon(Icons.phone, size: 20),
                      prefixText: '+91 ',
                      prefixStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      counterText: '', // Hide character counter
                    ),
                  ),
                ),
                if (_phoneNumbers.length > 1)
                  IconButton(
                    onPressed: () => _removePhoneNumber(index),
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                    iconSize: 24,
                  ),
                if (index ==
                    _phoneNumbers.length -
                        1) // Only show add button on last item
                  IconButton(
                    onPressed: _addPhoneNumber,
                    icon: Icon(Icons.add_circle,
                        color: Theme.of(context).primaryColor),
                    iconSize: 24,
                  ),
              ],
            ),
          );
        }),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildMultipleLandmarks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(_landmarks.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: _landmarks[index],
                    onChanged: (value) => _landmarks[index] = value,
                    decoration: InputDecoration(
                      hintText: 'Landmark',
                      prefixIcon: const Icon(Icons.location_on, size: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                    ),
                  ),
                ),
                if (_landmarks.length > 1)
                  IconButton(
                    onPressed: () => _removeLandmark(index),
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                    iconSize: 20,
                  ),
                IconButton(
                  onPressed: _addLandmark,
                  icon: Icon(Icons.add_circle,
                      color: Theme.of(context).primaryColor),
                  iconSize: 20,
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 16),
      ],
    );
  }

  // Updated image picker method

  List<String> _getUniqueValues(String fieldName) {
    return widget.properties
        .map((p) => p[fieldName]?.toString().trim() ?? '')
        .where((value) => value.isNotEmpty && value != 'N/A')
        .toSet() // This removes duplicates
        .toList()
      ..sort(); // Sort alphabetically
  }

  List<String> _getSuggestions(String fieldName, String pattern) {
    final values = _getUniqueValues(fieldName);
    if (pattern.isEmpty) {
      return values.take(10).toList(); // Limit to 10 suggestions
    }
    return values
        .where((value) => value.toLowerCase().contains(pattern.toLowerCase()))
        .take(10) // Limit suggestions
        .toList();
  }

  Widget _buildWhatsAppTextField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: _whatsappController,
        keyboardType: TextInputType.phone,
        maxLength: 10,
        validator: (value) {
          if (value != null && value.isNotEmpty) {
            if (value.length != 10) {
              return 'Please enter a valid 10-digit mobile number';
            }
            if (!RegExp(r'^[6-9][0-9]{9}$').hasMatch(value)) {
              return 'Please enter a valid Indian mobile number';
            }
          }
          return null;
        },
        style: GoogleFonts.poppins(fontSize: 14),
        decoration: InputDecoration(
          labelText: 'WhatsApp Number',
          hintText: '9876543210',
          prefixIcon: const Icon(FontAwesomeIcons.whatsapp,
              size: 20, color: Colors.green),
          prefixText: '+91 ',
          prefixStyle: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          counterText: '', // Hide character counter
          helperText: 'Enter 10-digit mobile number',
          helperStyle:
              GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
      insetPadding: const EdgeInsets.all(0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 600,
          maxHeight: MediaQuery.of(context).size.height,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.existingProperty != null
                        ? 'Edit Property'
                        : 'Add New Property',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const Divider(height: 20),

              // Form
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTextField(
                              controller: _titleController,
                              label: 'Property Title',
                              hint: 'e.g., Premium Villa in Velachery',
                              validator: (value) => value?.isEmpty == true
                                  ? 'Title is required'
                                  : null,
                            ),

                            _buildDropdownField(
                              label: 'Property Type',
                              value: _selectedType,
                              items: _propertyTypes,
                              onChanged: (value) =>
                                  setState(() => _selectedType = value!),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: TypeAheadField<String>(
                                controller: _locationController,
                                suggestionsCallback: (pattern) {
                                  final suggestions =
                                      _getSuggestions('location', pattern);
                                  return suggestions.toSet().toList()..sort();
                                },
                                itemBuilder: (context, suggestion) => ListTile(
                                  leading:
                                      const Icon(Icons.location_on, size: 16),
                                  title: Text(
                                    suggestion,
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                ),
                                onSelected: (suggestion) =>
                                    _locationController.text = suggestion,
                                builder: (context, controller, focusNode) {
                                  return TextFormField(
                                    controller: controller,
                                    focusNode: focusNode,
                                    validator: (value) => value?.isEmpty == true
                                        ? 'Location is required'
                                        : null,
                                    style: GoogleFonts.poppins(fontSize: 14),
                                    decoration: InputDecoration(
                                      labelText: 'Location/Area *',
                                      hintText: 'e.g., Velachery, Anna Nagar',
                                      prefixIcon: const Icon(Icons.location_on,
                                          size: 20),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          width: 2,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey.shade50,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 16),
                                    ),
                                  );
                                },
                                emptyBuilder: (context) => const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                      'No locations found. Type to add new location.'),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: TypeAheadField<String>(
                                controller: _cityController,
                                suggestionsCallback: (pattern) {
                                  final suggestions =
                                      _getSuggestions('city', pattern);
                                  // Additional manual filtering to ensure no duplicates
                                  return suggestions.toSet().toList()..sort();
                                },
                                itemBuilder: (context, suggestion) => ListTile(
                                  leading:
                                      const Icon(Icons.location_city, size: 16),
                                  title: Text(
                                    suggestion,
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                ),
                                onSelected: (suggestion) =>
                                    _cityController.text = suggestion,
                                builder: (context, controller, focusNode) {
                                  return TextFormField(
                                    controller: controller,
                                    focusNode: focusNode,
                                    validator: (value) => value?.isEmpty == true
                                        ? 'City is required'
                                        : null,
                                    style: GoogleFonts.poppins(fontSize: 14),
                                    decoration: InputDecoration(
                                      labelText: 'City *',
                                      hintText: 'e.g., Chennai, Coimbatore',
                                      prefixIcon: const Icon(
                                          Icons.location_city,
                                          size: 20),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          width: 2,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey.shade50,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 16),
                                    ),
                                  );
                                },
                                emptyBuilder: (context) => const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                      'No cities found. Type to add new city.'),
                                ),
                              ),
                            ),

                            _buildMultipleLandmarks(),

                            _buildTextField(
                              controller: _mapLinkController,
                              label: 'Google Maps Link',
                              hint: 'https://maps.google.com/?q=...',
                            ),

                            _buildTextField(
                              controller: _priceController,
                              label: 'Price (₹)',
                              hint: '8500000₹',
                              keyboardType: TextInputType.number,
                              validator: (value) => value?.isEmpty == true
                                  ? 'Price is required'
                                  : null,
                              onChanged: (value) {
                                setState(
                                    () {}); // Trigger rebuild to update the display text
                              },
                            ),
                            if (_priceController.text.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, bottom: 4),
                                child: Text(
                                  _formatIndianNumber(_priceController.text),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            _buildTextField(
                              controller: _rentAmountController,
                              label: 'Monthly Rent (₹)',
                              hint: '25000',
                              keyboardType: TextInputType.number,
                            ),

                            _buildTextField(
                              controller: _waterTaxController,
                              label: 'Water Tax (₹)',
                              hint: '5000',
                              keyboardType: TextInputType.number,
                            ),

                            _buildTextField(
                              controller: _propertyTaxController,
                              label: 'Property Tax (₹)',
                              hint: '15000',
                              keyboardType: TextInputType.number,
                            ),

                            _buildTextField(
                              controller: _squareFeetController,
                              label: 'Square Feet',
                              hint: '2400',
                              keyboardType: TextInputType.number,
                            ),

                            _buildTextField(
                              controller: _builtupAreaController,
                              label: 'Built-up Area',
                              hint: '2200',
                              keyboardType: TextInputType.number,
                            ),

                            _buildTextField(
                              controller: _groundsController,
                              label: 'Grounds',
                              hint: '2.5',
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                            ),

                            _buildTextField(
                              controller: _bedroomsController,
                              label: 'Bedrooms',
                              hint: '3',
                              keyboardType: TextInputType.number,
                            ),

                            _buildTextField(
                              controller: _bathroomsController,
                              label: 'Bathrooms',
                              hint: '3',
                              keyboardType: TextInputType.number,
                            ),

                            _buildTextField(
                              controller: _ageYearsController,
                              label: 'How old is the property? (years)',
                              hint: '2',
                              keyboardType: TextInputType.number,
                            ),

                            // Multiple Phone Numbers
                            _buildMultiplePhoneNumbers(),

                            _buildWhatsAppTextField(),

                            // Property Images with enhanced upload options
                            _buildImageUploadSection(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        widget.existingProperty != null
                            ? 'Update Property'
                            : 'Add Property',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    final currentValue = items.contains(value) ? value : items.first;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        value: currentValue,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        items: items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(item, overflow: TextOverflow.ellipsis),
                ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
