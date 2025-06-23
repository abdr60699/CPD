import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  void _addImageUrl() {
    if (_imageUrlController.text.isNotEmpty) {
      setState(() {
        _imageUrls.add(_imageUrlController.text);
        _imageUrlController.clear();
      });
    }
  }

  void _removeImageUrl(int index) {
    setState(() {
      _imageUrls.removeAt(index);
    });
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

  Future<String?> _uploadImage(File imageFile) async {
    try {
      final fileName = 'property_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final filePath = 'property_images/$fileName';

      // Upload file to Supabase Storage
      await Supabase.instance.client.storage
          .from(
              'property-images') // Make sure this bucket exists in your Supabase storage
          .upload(filePath, imageFile);

      // Get public URL
      final imageUrl = Supabase.instance.client.storage
          .from('property-images')
          .getPublicUrl(filePath);

      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

// Fixed submit form method with proper +91 handling
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final validPhoneNumbers =
          _phoneNumbers.where((phone) => phone.trim().isNotEmpty).map((phone) {
        String cleanPhone = phone.trim();
        return cleanPhone.startsWith('+91') ? cleanPhone : '+91$cleanPhone';
      }).toList();

      final validLandmarks =
          _landmarks.where((landmark) => landmark.trim().isNotEmpty).toList();

      // Process WhatsApp number
      String whatsappNumber = _whatsappController.text.trim();
      if (whatsappNumber.isNotEmpty && !whatsappNumber.startsWith('+91')) {
        whatsappNumber = '+91$whatsappNumber';
      }

      final propertyData = {
        'header': _headerController.text,
        'title': _titleController.text,
        'type': _selectedType,
        'location': _locationController.text.isNotEmpty
            ? _locationController.text
            : _selectedLocation,
        'city': _cityController.text.isNotEmpty
            ? _cityController.text
            : _selectedCity,
        'price': double.tryParse(_priceController.text) ?? 0,
        'squareFeet': double.tryParse(_squareFeetController.text) ?? 0,
        'grounds': double.tryParse(_groundsController.text) ?? 0,
        'builtupArea': double.tryParse(_builtupAreaController.text) ?? 0,
        'landmarks': validLandmarks,
        'mapLink': _mapLinkController.text,
        'waterTax': double.tryParse(_waterTaxController.text) ?? 0,
        'propertyTax': double.tryParse(_propertyTaxController.text) ?? 0,
        'bedrooms': int.tryParse(_bedroomsController.text) ?? 0,
        'bathrooms': int.tryParse(_bathroomsController.text) ?? 0,
        'ageYears': int.tryParse(_ageYearsController.text) ?? 0,
        'forRent': _forRent,
        'rentAmount': double.tryParse(_rentAmountController.text) ?? 0,
        'images': _imageUrls,
        'contact': {
          'phoneNumbers': validPhoneNumbers,
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
        ...List.generate(_phoneNumbers.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: _phoneNumbers[index],
                    keyboardType: TextInputType.phone,
                    onChanged: (value) => _phoneNumbers[index] = value,
                    validator: (value) {
                      if (index == 0 && (value?.isEmpty == true)) {
                        return 'At least one phone number is required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: '9876543210',
                      prefixIcon: const Icon(Icons.phone, size: 20),
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
                    ),
                  ),
                ),
                if (_phoneNumbers.length > 1)
                  IconButton(
                    onPressed: () => _removePhoneNumber(index),
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                    iconSize: 24,
                  ),
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

  Widget _buildImageUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _imageUrlController,
                label: 'Image URL',
                hint: 'https://example.com/image.jpg',
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
                label: const Text('Gallery'),
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

        // Image preview
        if (_imageUrls.isNotEmpty)
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _imageUrls.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          _imageUrls[index],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey[300],
                              child: Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey[300],
                              child: const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.error, color: Colors.red),
                                    Text("Error",
                                        style: TextStyle(fontSize: 12)),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
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
      ],
    );
  }

  // Updated image picker method
  Future<void> _pickImageFile(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _isUploading = true;
        });

        // Upload to your preferred service
        String? imageUrl = await _uploadImage(File(image.path));

        if (imageUrl != null) {
          setState(() {
            _imageUrls.add(imageUrl);
            _isUploading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Image uploaded successfully!')),
          );
        } else {
          setState(() {
            _isUploading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to upload image')),
          );
        }
      }
    } catch (e) {
      setState(() {
        _isUploading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  List<String> _getUniqueValues(String fieldName) {
    return widget.properties
        .map((p) => p[fieldName]?.toString() ?? '')
        .where((value) => value.isNotEmpty)
        .toSet()
        .toList();
  }

  List<String> _getSuggestions(String fieldName, String pattern) {
    final values = _getUniqueValues(fieldName);
    if (pattern.isEmpty) return values;
    return values
        .where((value) => value.toLowerCase().contains(pattern.toLowerCase()))
        .toList();
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
                              suggestionsCallback: (pattern) =>
                                  _getSuggestions('location', pattern),
                              itemBuilder: (context, suggestion) =>
                                  ListTile(title: Text(suggestion)),
                              onSelected: (suggestion) =>
                                  _locationController.text = suggestion,
                              builder: (context, controller, focusNode) {
                                return TextFormField(
                                  controller: controller,
                                  focusNode: focusNode,
                                  decoration: InputDecoration(
                                    labelText: 'Location',
                                    hintText: 'e.g., Velachery, Chennai',
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
                                  ),
                                );
                              },
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: TypeAheadField<String>(
                              controller: _cityController,
                              suggestionsCallback: (pattern) =>
                                  _getSuggestions('city', pattern),
                              itemBuilder: (context, suggestion) =>
                                  ListTile(title: Text(suggestion)),
                              onSelected: (suggestion) =>
                                  _cityController.text = suggestion,
                              builder: (context, controller, focusNode) {
                                return TextFormField(
                                  controller: controller,
                                  focusNode: focusNode,
                                  decoration: InputDecoration(
                                    labelText: 'City',
                                    hintText: 'e.g., Chennai, Coimbatore',
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
                                  ),
                                );
                              },
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
                              padding:
                                  const EdgeInsets.only(left: 12.0, bottom: 4),
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
                            keyboardType: const TextInputType.numberWithOptions(
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

                          _buildTextField(
                            controller: _whatsappController,
                            label: 'WhatsApp Number',
                            hint: '+919876543210',
                            keyboardType: TextInputType.phone,
                          ),

                          // Property Images with enhanced upload options
                          _buildImageUploadSection(),
                        ],
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
