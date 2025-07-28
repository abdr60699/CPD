
  // Future<void> _loadProperties1() async {
  //   setState(() => _isLoading = true);
  //   try {
  //     final properties = await _propertyService.fetchProperties();
  //     print('Total properties fetched: ${properties.length}');

  //     // Debug: Print each property title and key data
  //     for (int i = 0; i < properties.length; i++) {
  //       final prop = properties[i];
  //       print(
  //           'Property $i: ${prop['title']} - City: ${prop['city']} - Type: ${prop['type']}');
  //     }

  //     // Extract unique locations from properties
  //     final uniqueLocations = properties
  //         .map((p) => p['city']?.toString() ?? '')
  //         .where((loc) => loc.isNotEmpty && loc != 'N/A')
  //         .toSet()
  //         .toList();

  //     print('Unique locations found: $uniqueLocations');

  //     setState(() {
  //       _properties.clear();
  //       _properties.addAll(properties);
  //       _locations = ['All Locations', ...uniqueLocations];
  //       print('Properties in state: ${_properties.length}');
  //       print('Locations in state: $_locations');
  //     });
  //   } catch (e) {
  //     print('Error loading properties: $e');
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Error loading properties: $e')),
  //       );
  //     }
  //   } finally {
  //     setState(() => _isLoading = false);
  //   }
  // }

  //   Widget _buildSearchSection() {
  //   return Container(
  //     padding: const EdgeInsets.only(left: 24, right: 24, top: 10),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(16),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey.withOpacity(0.15),
  //           spreadRadius: 0,
  //           blurRadius: 20,
  //           offset: const Offset(0, 8),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'Find Your Perfect Property',
  //           style: GoogleFonts.poppins(
  //             fontSize: 18,
  //             color: const Color(0xFF333333),
  //           ),
  //         ),

  //         const SizedBox(height: 10),

  //         /// 🔍 Search Field
  //         _buildSearchField(
  //           child: TypeAheadField<String>(
  //             controller: _searchController,
  //             builder: (context, controller, focusNode) {
  //               return TextField(
  //                 controller: controller,
  //                 focusNode: focusNode,
  //                 style: GoogleFonts.poppins(fontSize: 14),
  //                 decoration: InputDecoration(
  //                   labelText: 'Search Location',
  //                   labelStyle:
  //                       const TextStyle(color: Color(0xFF333333), fontSize: 14),
  //                   hintText: 'e.g., Velachery, Chennai',
  //                   prefixIcon: Icon(
  //                     FontAwesomeIcons.locationDot,
  //                     color: Theme.of(context).colorScheme.primary,
  //                     size: 20,
  //                   ),
  //                   border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(12),
  //                     borderSide: BorderSide(color: Colors.grey.shade300),
  //                   ),
  //                   focusedBorder: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(12),
  //                     borderSide: BorderSide(
  //                       color: Theme.of(context).colorScheme.primary,
  //                       width: 2,
  //                     ),
  //                   ),
  //                   enabledBorder: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(12),
  //                     borderSide: BorderSide(color: Colors.grey.shade300),
  //                   ),
  //                   filled: true,
  //                   fillColor: Colors.grey.shade50,
  //                   contentPadding: const EdgeInsets.symmetric(
  //                     horizontal: 20,
  //                     vertical: 16,
  //                   ),
  //                 ),
  //               );
  //             },
  //             suggestionsCallback: (pattern) =>
  //                 pattern.isEmpty ? [] : _getAreaSuggestions(pattern),
  //             itemBuilder: (context, suggestion) => Padding(
  //               padding: const EdgeInsets.all(12),
  //               child: Row(
  //                 children: [
  //                   Icon(FontAwesomeIcons.locationDot,
  //                       color: Theme.of(context).colorScheme.primary, size: 14),
  //                   const SizedBox(width: 12),
  //                   Expanded(
  //                     child: Text(
  //                       suggestion,
  //                       style: GoogleFonts.poppins(fontSize: 14),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             onSelected: (suggestion) => _searchController.text = suggestion,
  //             decorationBuilder: (context, child) => Material(
  //               elevation: 8,
  //               borderRadius: BorderRadius.circular(12),
  //               child: child,
  //             ),
  //           ),
  //         ),
  //         const SizedBox(height: 16),
  //         LayoutBuilder(
  //           builder: (context, constraints) {
  //             final isNarrow = constraints.maxWidth < 360;

  //             if (isNarrow) {
  //               // Stack in Column on very small screens
  //               return Column(
  //                 children: [
  //                   _buildDropdownField(
  //                     label: 'Property Type',
  //                     value: _selectedPropertyType,
  //                     items: _propertyTypes,
  //                     icon: FontAwesomeIcons.building,
  //                     onChanged: (value) =>
  //                         setState(() => _selectedPropertyType = value!),
  //                   ),
  //                   const SizedBox(height: 12),
  //                   _buildDropdownField(
  //                     label: 'City',
  //                     value: _selectedLocation,
  //                     items: _locations,
  //                     icon: FontAwesomeIcons.city,
  //                     onChanged: (value) =>
  //                         setState(() => _selectedLocation = value!),
  //                   ),
  //                 ],
  //               );
  //             } else {
  //               // Regular Row for wider screens
  //               return Row(
  //                 children: [
  //                   Flexible(
  //                     flex: 1,
  //                     child: _buildDropdownField(
  //                       label: 'Property Type',
  //                       value: _selectedPropertyType,
  //                       items: _propertyTypes,
  //                       icon: FontAwesomeIcons.building,
  //                       onChanged: (value) =>
  //                           setState(() => _selectedPropertyType = value!),
  //                     ),
  //                   ),
  //                   const SizedBox(width: 12),
  //                   Flexible(
  //                     flex: 1,
  //                     child: _buildDropdownField(
  //                       label: 'City',
  //                       value: _selectedLocation,
  //                       items: _locations,
  //                       icon: FontAwesomeIcons.city,
  //                       onChanged: (value) =>
  //                           setState(() => _selectedLocation = value!),
  //                     ),
  //                   ),
  //                 ],
  //               );
  //             }
  //           },
  //         ),

  //         const SizedBox(height: 20),
  //         Container(
  //           padding: const EdgeInsets.all(16),
  //           decoration: BoxDecoration(
  //             color: Colors.grey.shade50,
  //             borderRadius: BorderRadius.circular(12),
  //             border: Border.all(color: Colors.grey.shade200),
  //           ),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     'Budget Range',
  //                     style: GoogleFonts.poppins(
  //                       fontSize: 14,
  //                       fontWeight: FontWeight.w600,
  //                       color: Colors.grey,
  //                     ),
  //                   ),
  //                   const SizedBox(height: 20),

  //                   /// Price tags (below label)
  //                   SizedBox(
  //                     width: double.infinity,
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         _buildPriceTag(
  //                             context, _formatPrice(_priceRange.start)),
  //                         _buildPriceTag(
  //                             context, _formatPrice(_priceRange.end)),
  //                       ],
  //                     ),
  //                   ),
  //                   const SizedBox(height: 10),

  //                   /// Range Slider
  //                   SliderTheme(
  //                     data: SliderTheme.of(context).copyWith(
  //                       activeTrackColor: Theme.of(context).colorScheme.primary,
  //                       inactiveTrackColor: Colors.grey.shade300,
  //                       thumbColor: Theme.of(context).colorScheme.primary,
  //                       overlayColor: Theme.of(context)
  //                           .colorScheme
  //                           .primary
  //                           .withOpacity(0.2),
  //                       thumbShape:
  //                           const RoundSliderThumbShape(enabledThumbRadius: 12),
  //                       trackHeight: 4,
  //                     ),
  //                     child: RangeSlider(
  //                       values: _priceRange,
  //                       min: 100000, // ₹1 Lakh
  //                       max: 200000000, // ₹20 Crore
  //                       divisions: 100,
  //                       labels: RangeLabels(
  //                         _formatPrice(_priceRange.start),
  //                         _formatPrice(_priceRange.end),
  //                       ),
  //                       onChanged: (values) {
  //                         setState(() => _priceRange = values);
  //                       },
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),

  //         const SizedBox(
  //           height: 20,
  //         ),
  //         Row(
  //           children: [
  //             Flexible(
  //               flex: 1,
  //               child: OutlinedButton(
  //                 onPressed: () {
  //                   setState(() {
  //                     _searchController.clear();
  //                     _selectedPropertyType = 'All Properties';
  //                     _selectedLocation = 'All Locations';
  //                     _priceRange = const RangeValues(1000000, 10000000);
  //                   });
  //                   ScaffoldMessenger.of(context).showSnackBar(
  //                     SnackBar(
  //                       content: const Text('Filters cleared'),
  //                       backgroundColor: Colors.grey[700],
  //                       behavior: SnackBarBehavior.floating,
  //                     ),
  //                   );
  //                 },
  //                 style: OutlinedButton.styleFrom(
  //                   padding: const EdgeInsets.symmetric(vertical: 16),
  //                   side: BorderSide(color: Colors.grey.shade400),
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(12),
  //                   ),
  //                 ),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Icon(
  //                       FontAwesomeIcons.rotateLeft,
  //                       size: 16,
  //                       color: Colors.grey[600],
  //                     ),
  //                     const SizedBox(width: 8),
  //                     Text(
  //                       'Clear',
  //                       style: GoogleFonts.poppins(
  //                         fontWeight: FontWeight.w600,
  //                         color: Colors.grey[600],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(width: 12),
  //             Flexible(
  //               flex: 2,
  //               child: ElevatedButton(
  //                 onPressed: () {
  //                   setState(() {
  //                     // Apply filters
  //                   });

  //                   final count = filteredProperties.length;
  //                   ScaffoldMessenger.of(context).showSnackBar(
  //                     SnackBar(
  //                       content: Text(
  //                           'Found $count properties matching your criteria'),
  //                       backgroundColor: Theme.of(context).colorScheme.primary,
  //                       behavior: SnackBarBehavior.floating,
  //                       action: count > 0
  //                           ? SnackBarAction(
  //                               label: 'View',
  //                               textColor: Colors.white,
  //                               onPressed: () {
  //                                 // Scroll to section
  //                               },
  //                             )
  //                           : null,
  //                     ),
  //                   );
  //                 },
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: Theme.of(context).colorScheme.primary,
  //                   foregroundColor: Colors.white,
  //                   padding: const EdgeInsets.symmetric(vertical: 16),
  //                   elevation: 0,
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(12),
  //                   ),
  //                 ),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     const Icon(FontAwesomeIcons.magnifyingGlass, size: 16),
  //                     const SizedBox(width: 8),
  //                     Text(
  //                       'SEARCH PROPERTIES',
  //                       style: GoogleFonts.poppins(
  //                         fontWeight: FontWeight.w600,
  //                         fontSize: 14,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(
  //           height: 20,
  //         )
  //       ],
  //     ),
  //   );
  // }



//   whats app and map working fine but phone is not working and below is the coming data{"city": "Chennai", "type": "Apartment", "price": 6666666.0, "title": "ffffff", "header": "", "images": [], "contact": {"phone": "+919500863174", "whatsapp": "", "phoneNumbers": ["+919500863174", "+919884433545"]}, "forRent": false, "grounds": 0.0, "mapLink": "", "ageYears": 0, "bedrooms": 0, "location": "Avadi", "waterTax": 0.0, "bathrooms": 0, "landmarks": [], "rentAmount": 0.0, "squareFeet": 0.0, "builtupArea": 0.0, "propertyTax": 0.0}

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _selectedIndex = 0;
//   final TextEditingController _searchController = TextEditingController();
//   String _selectedPropertyType = 'All Properties';
//   final String _selectedLocation = 'All Locations';
//   RangeValues _priceRange = const RangeValues(100000, 100000000);
//   final PropertyService _propertyService = PropertyService();
//   bool _isLoading = false;
//   final List<Map<String, dynamic>> _properties = [];
//   bool isMobile = false;

//   // Replace _selectedAreas with _selectedCities and add _cities list
//   List<String> _selectedLocations = ['All Locations'];
//   List<String> _selectedCities = [];

//   // Sample data - replace with your actual data
//   List<String> _locations = ['All Locations'];
//   List<String> _cities = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadProperties();
//   }

//   // Initialize with default value

//   Future<void> _addProperty(Map<String, dynamic> propertyData) async {
//     setState(() => _isLoading = true);
//     try {
//       final success = await _propertyService.addProperty(propertyData);
//       if (success) {
//         await _loadProperties(); // Refresh the list
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Property added successfully!'),
//               backgroundColor: Colors.green,
//             ),
//           );
//         }
//       } else {
//         throw Exception('Failed to add property');
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error adding property: $e')),
//         );
//       }
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   bool _isNewProject(Map<String, dynamic> property) {
//     try {
//       final createdDate = property['createdDate'] ??
//           property['created_at'] ??
//           property['dateCreated'];
//       if (createdDate == null) return false;

//       DateTime propertyDate;
//       if (createdDate is String) {
//         propertyDate = DateTime.parse(createdDate);
//       } else if (createdDate is DateTime) {
//         propertyDate = createdDate;
//       } else {
//         return false;
//       }

//       final now = DateTime.now();
//       final oneMonthAgo = now.subtract(const Duration(days: 30));

//       return propertyDate.isAfter(oneMonthAgo);
//     } catch (e) {
//       print('Error parsing date for property: $e');
//       return false;
//     }
//   }

// // 6. Update the filteredProperties getter to handle search better and new projects
 

//   // Handles the phone button logic: calls directly if one number, shows dialog if multiple
//   void _handlePhoneButton(Map<String, dynamic>? contact) {
//     print('DEBUG: _handlePhoneButton called with contact: $contact');
//     if (contact == null) {
//       _showSnackBar('No contact information available');
//       return;
//     }

//     // Gather all possible phone numbers (deduplicated, non-empty)
//     final Set<String> numbers = {};
//     final directPhone = contact['phone']?.toString().trim() ?? '';
//     if (directPhone.isNotEmpty) numbers.add(directPhone);
//     final phoneNumbers = contact['phoneNumbers'] as List<dynamic>?;
//     if (phoneNumbers != null) {
//       for (var n in phoneNumbers) {
//         final s = n.toString().trim();
//         if (s.isNotEmpty) numbers.add(s);
//       }
//     }
//     final allNumbers = numbers.toList();

//     if (allNumbers.isEmpty) {
//       _showSnackBar('No phone number available');
//       return;
//     }
//     if (allNumbers.length == 1) {
//       _callPhone(contact, allNumbers.first);
//     } else {
//       // Show dialog to pick a number
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Select a number to call'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: allNumbers
//                 .map((number) => ListTile(
//                       leading: const Icon(Icons.phone),
//                       title: Text(number),
//                       onTap: () {
//                         Navigator.of(context).pop();
//                         _callPhone(contact, number);
//                       },
//                     ))
//                 .toList(),
//           ),
//         ),
//       );
//     }
//   }

//   // Updated _callPhone method to handle the correct data structure and optionally call a specific number
//   void _callPhone(Map<String, dynamic>? contact, [String? overrideNumber]) {
//     print(
//         'DEBUG: _callPhone called with contact: $contact, overrideNumber: $overrideNumber');
//     if (contact == null && overrideNumber == null) {
//       _showSnackBar('No contact information available');
//       return;
//     }

//     String phoneNumber = '';
//     if (overrideNumber != null && overrideNumber.trim().isNotEmpty) {
//       phoneNumber = overrideNumber.trim();
//     } else {
//       // First try to get from the 'phone' field
//       final directPhone = contact?['phone']?.toString().trim() ?? '';
//       if (directPhone.isNotEmpty) {
//         phoneNumber = directPhone;
//       } else {
//         // Fallback to phoneNumbers array
//         final phoneNumbers = contact?['phoneNumbers'] as List<dynamic>?;
//         if (phoneNumbers != null && phoneNumbers.isNotEmpty) {
//           phoneNumber = phoneNumbers.first.toString().trim();
//         }
//       }
//     }

//     if (phoneNumber.isEmpty) {
//       _showSnackBar('No phone number available');
//       return;
//     }

//     // Clean up phone number - remove all non-digit characters except +
//     final cleaned = phoneNumber.replaceAll(RegExp(r'[^0-9+]'), '');

//     if (kIsWeb) {
//       _showSnackBar('Phone calls are not supported on web');
//       return;
//     }

//     print('DEBUG: Launching tel:$cleaned');
//     _launchURL('tel:$cleaned');
//   }

//   // Also update the _openWhatsApp method to use the same logic for consistency
//   void _openWhatsApp(Map<String, dynamic>? contact) {
//     print('DEBUG: _openWhatsApp called with contact: $contact');
//     if (contact == null) {
//       _showSnackBar('No contact information available');
//       return;
//     }

//     String phoneNumber = '';

//     // First try to get from whatsapp field
//     final whatsappNumber = contact['whatsapp']?.toString().trim() ?? '';

//     if (whatsappNumber.isNotEmpty) {
//       phoneNumber = whatsappNumber;
//     } else {
//       // Try the direct phone field
//       final directPhone = contact['phone']?.toString().trim() ?? '';
//       if (directPhone.isNotEmpty) {
//         phoneNumber = directPhone;
//       } else {
//         // Fallback to phoneNumbers array
//         final phoneNumbers = contact['phoneNumbers'] as List<dynamic>?;
//         if (phoneNumbers != null && phoneNumbers.isNotEmpty) {
//           phoneNumber = phoneNumbers.first.toString().trim();
//         }
//       }
//     }

//     if (phoneNumber.isEmpty) {
//       _showSnackBar('No WhatsApp number available');
//       return;
//     }

//     // Clean up phone number and ensure it has country code
//     String cleaned = phoneNumber.replaceAll(RegExp(r'[^0-9+]'), '');

//     // If number doesn't start with '+', assume it's an Indian number (+91)
//     if (!cleaned.startsWith('+')) {
//       // Remove any leading zeros
//       cleaned = cleaned.replaceAll(RegExp(r'^0+'), '');
//       // Add Indian country code if not present
//       if (!cleaned.startsWith('91') && cleaned.length == 10) {
//         cleaned = '91$cleaned';
//       }
//       cleaned = '+$cleaned';
//     }

//     print(
//         'DEBUG: Launching https://wa.me/${cleaned.substring(1)}'); // Remove + for WhatsApp URL
//     _launchURL('https://wa.me/${cleaned.substring(1)}');
//   }

//   Future<void> _launchURL(String url) async {
//     print('DEBUG: _launchURL called with url: $url');
//     if (url.isEmpty) {
//       _showSnackBar('No URL provided');
//       return;
//     }

//     try {
//       // Ensure the URL has a proper scheme
//       String processedUrl = url;
//       if (!url.startsWith('http://') &&
//           !url.startsWith('https://') &&
//           !url.startsWith('tel:') &&
//           !url.startsWith('mailto:')) {
//         processedUrl = 'https://$url';
//       }

//       print('DEBUG: Processed URL to launch: $processedUrl');
//       if (await canLaunchUrlString(processedUrl)) {
//         await launchUrlString(
//           processedUrl,
//           mode: LaunchMode.externalApplication,
//         );
//       } else {
//         _showSnackBar('Could not launch URL: $processedUrl');
//       }
//     } catch (e) {
//       _showSnackBar('Error launching URL:  e.toString()}');
//     }
//   }

//   Widget _buildBody() {
//     switch (_selectedIndex) {
//       case 0:
//         return _buildHomePage();
//       default:
//         return _buildHomePage();
//     }
//   }

 

//   Widget _buildFeaturedProperties() {
//     if (_isLoading && _properties.isEmpty) {
//       return const Center(
//         child: Padding(
//           padding: EdgeInsets.all(20),
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }

//     if (filteredProperties.isEmpty) {
//       return Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Center(
//           child: Column(
//             children: [
//               const Icon(Icons.search_off, size: 64, color: Colors.grey),
//               const SizedBox(height: 16),
//               Text(
//                 _properties.isEmpty
//                     ? 'No properties available'
//                     : 'No properties found matching your criteria',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.grey.shade700,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               if (_properties.isEmpty)
//                 TextButton(
//                   onPressed: _loadProperties,
//                   child: const Text('Retry'),
//                 ),
//             ],
//           ),
//         ),
//       );
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: FadeInLeft(
//                   child: Text(
//                     'Featured Properties',
//                     style: GoogleFonts.poppins(
//                       fontSize: 18,
//                       color: const Color(0xFF333333),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: LayoutBuilder(
//             builder: (context, constraints) {
//               if (_isLoading && _properties.isEmpty) {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }

//               final isMobile = constraints.maxWidth > 600;
//               int crossAxisCount = 1;
//               if (constraints.maxWidth > 600) {
//                 crossAxisCount = 2;
//               }
//               if (constraints.maxWidth > 900) {
//                 crossAxisCount = 3;
//               }

//               return MasonryGridView.count(
//                 crossAxisCount: crossAxisCount,
//                 mainAxisSpacing: 8,
//                 crossAxisSpacing: 16,
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: filteredProperties.length,
//                 itemBuilder: (context, index) {
//                   final property = filteredProperties[index];
//                   return FadeInUp(
//                     delay: Duration(milliseconds: 100 * index),
//                     child: PropertyCard(
//                       isMobile: isMobile,
//                       property: property,
//                       onPhonePressed: () =>
//                           _handlePhoneButton(property['contact']),
//                       onWhatsAppPressed: () =>
//                           _openWhatsApp(property['contact']),
//                       onMapPressed: () => _launchURL(property['mapLink']),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   // Add this new method to build city chips:
 
//   @override
//   Widget build(BuildContext context) {
//     isMobile = MediaQuery.of(context).size.width < 600;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: buildResponsiveAppBar(context, _selectedIndex, (index) {
//         setState(() {
//           _selectedIndex = index;
//         });
//       }),
//       body: _isLoading
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : RefreshIndicator(
//               onRefresh: _loadProperties,
//               child: _buildBody(),
//             ),
//       floatingActionButton: !kIsWeb
//           ? FloatingActionButton(
//               backgroundColor: Theme.of(context).colorScheme.primary,
//               onPressed: _showAddPropertyDialog,
//               tooltip: 'Add Property',
//               child: const Icon(Icons.add),
//             )
//           : null,
//     );
//   }
// }
