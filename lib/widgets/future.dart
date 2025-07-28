// Widget _buildQuickStat(String label, String value, IconData icon) {
//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Icon(
//             icon,
//             color: Theme.of(context).colorScheme.primary,
//             size: 16,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           value,
//           style: GoogleFonts.poppins(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: Theme.of(context).colorScheme.primary,
//           ),
//         ),
//         Text(
//           label,
//           style: GoogleFonts.poppins(
//             fontSize: 12,
//             color: Colors.grey[600],
//           ),
//         ),
//       ],
//     );
//   }






//dummy


  // final List<String> _locations = [
  //   'All Locations',
  //   'Chennai',
  //   'Coimbatore',
  //   'Madurai',
  //   'Salem',
  //   'Tiruppur'
  // ];

  // final List<Map<String, dynamic>> _properties = [
  //   {
  //     'id': 1,
  //     'title': 'Premium Villa in Velachery',
  //     'type': 'Villa',
  //     'location': 'Velachery',
  //     'price': 8500000,
  //     'squareFeet': 2400,
  //     'grounds': 2.5,
  //     'builtupArea': 2200,
  //     'landmark': 'Near Phoenix Mall',
  //     'mapLink': 'https://maps.google.com/?q=Velachery,Chennai',
  //     'waterTax': 5000,
  //     'propertyTax': 15000,
  //     'city': 'Chennai',
  //     'bedrooms': 3,
  //     'bathrooms': 3,
  //     'ageYears': 2,
  //     'forRent': false,
  //     'rentAmount': 0,
  //     'images': [
  //       'https://images.unsplash.com/photo-1690900257842-f78779d310cd?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8ZW1wdHklMjBsYW5kJTIwcGljdHVyZXMlMjBmb3IlMjBidWlsZGluZyUyMGluJTIwaW5kaWF8ZW58MHx8MHx8fDA%3D',
  //       'https://images.unsplash.com/photo-1630240976913-ce903373e752?q=80&w=1926&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  //       'https://images.unsplash.com/photo-1649663891220-1bff96da78b2?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGVtcHR5JTIwbGFuZCUyMHBpY3R1cmVzJTIwZm9yJTIwYnVpbGRpbmclMjBpbiUyMGluZGlhfGVufDB8fDB8fHww',
  //       "https://www.youtube.com/watch?v=if9mboENc74"
  //     ],
  //     'contact': {'phone': '+919876543210', 'whatsapp': '+919876543210'}
  //   },
  //   {
  //     'id': 2,
  //     'title': '3BHK Apartment in Adyar',
  //     'type': 'Apartment',
  //     'location': 'Adyar, Chennai',
  //     'price': 6500000,
  //     'squareFeet': 1500,
  //     'grounds': 0,
  //     'builtupArea': 1450,
  //     'landmark': 'Near Adyar Signal',
  //     'mapLink': '',
  //     'waterTax': 3500,
  //     'propertyTax': 12000,
  //     'city': 'Chennai',
  //     'bedrooms': 3,
  //     'bathrooms': 2,
  //     'ageYears': 5,
  //     'forRent': false,
  //     'rentAmount': 0,
  //     'images': [
  //       'https://images.unsplash.com/photo-1690900257842-f78779d310cd?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8ZW1wdHklMjBsYW5kJTIwcGljdHVyZXMlMjBmb3IlMjBidWlsZGluZyUyMGluJTIwaW5kaWF8ZW58MHx8MHx8fDA%3D',
  //       'https://images.unsplash.com/photo-1630240976913-ce903373e752?q=80&w=1926&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  //       'https://images.unsplash.com/photo-1649663891220-1bff96da78b2?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGVtcHR5JTIwbGFuZCUyMHBpY3R1cmVzJTIwZm9yJTIwYnVpbGRpbmclMjBpbiUyMGluZGlhfGVufDB8fDB8fHww'
  //     ],
  //     'contact': {'phone': '+919876543211', 'whatsapp': '+919876543211'}
  //   },
  //   {
  //     'id': 3,
  //     'title': 'Commercial Space in T. Nagar',
  //     'type': 'Commercial',
  //     'location': 'T. Nagar, Chennai',
  //     'price': 15000000,
  //     'squareFeet': 3500,
  //     'grounds': 1.8,
  //     'builtupArea': 3400,
  //     'landmark': 'Near Panagal Park',
  //     'mapLink': 'https://maps.google.com/?q=T.Nagar,Chennai',
  //     'waterTax': 8500,
  //     'propertyTax': 35000,
  //     'city': 'Chennai',
  //     'bedrooms': 0,
  //     'bathrooms': 4,
  //     'ageYears': 1,
  //     'forRent': false,
  //     'rentAmount': 0,
  //     'images': [
  //       'https://images.unsplash.com/photo-1690900257842-f78779d310cd?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8ZW1wdHklMjBsYW5kJTIwcGljdHVyZXMlMjBmb3IlMjBidWlsZGluZyUyMGluJTIwaW5kaWF8ZW58MHx8MHx8fDA%3D',
  //       'https://images.unsplash.com/photo-1630240976913-ce903373e752?q=80&w=1926&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  //       'https://images.unsplash.com/photo-1649663891220-1bff96da78b2?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGVtcHR5JTIwbGFuZCUyMHBpY3R1cmVzJTIwZm9yJTIwYnVpbGRpbmclMjBpbiUyMGluZGlhfGVufDB8fDB8fHww'
  //     ],
  //     'contact': {'phone': '+919876543212', 'whatsapp': '+919876543212'}
  //   },
  // ];



// CHANGES NEEDED IN YOUR HOME PAGE:

// // 1. OPTIMIZE SEARCH FIELD LENGTH - Replace the _buildSearchSection() method:
// Widget _buildSearchSection() {
//   return Container(
//     margin: const EdgeInsets.all(16), // Add margin for better spacing
//     padding: const EdgeInsets.all(20),
//     decoration: BoxDecoration(
//       gradient: LinearGradient( // Add gradient for attractiveness
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//         colors: [
//           Colors.white,
//           Colors.blue.shade50,
//         ],
//       ),
//       borderRadius: BorderRadius.circular(20), // Increased border radius
//       boxShadow: [
//         BoxShadow(
//           color: Colors.grey.withOpacity(0.2),
//           spreadRadius: 2,
//           blurRadius: 15,
//           offset: const Offset(0, 5),
//         ),
//       ],
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Improved header with icon
//         Row(
//           children: [
//             Icon(
//               FontAwesomeIcons.search,
//               color: Theme.of(context).colorScheme.primary,
//               size: 20,
//             ),
//             const SizedBox(width: 10),
//             Text(
//               'Find Your Perfect Property',
//               style: GoogleFonts.poppins(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w600,
//                 color: const Color(0xFF333333),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),

//         // OPTIMIZED SEARCH FIELD - Limited width for better UX
//         ConstrainedBox(
//           constraints: const BoxConstraints(
//             maxWidth: 400, // LIMIT THE MAX WIDTH HERE
//           ),
//           child: _buildSearchField(
//             child: TypeAheadField<String>(
//               controller: _searchController,
//               builder: (context, controller, focusNode) {
//                 return TextField(
//                   controller: controller,
//                   focusNode: focusNode,
//                   style: GoogleFonts.poppins(fontSize: 14),
//                   decoration: InputDecoration(
//                     labelText: 'Search Location',
//                     labelStyle: TextStyle(
//                       color: Colors.grey.shade600,
//                       fontSize: 14,
//                     ),
//                     hintText: 'e.g., Velachery, Chennai',
//                     hintStyle: TextStyle(color: Colors.grey.shade400),
//                     prefixIcon: Container(
//                       margin: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Icon(
//                         FontAwesomeIcons.locationDot,
//                         color: Theme.of(context).colorScheme.primary,
//                         size: 18,
//                       ),
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide(color: Colors.grey.shade300),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide(
//                         color: Theme.of(context).colorScheme.primary,
//                         width: 2,
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide(color: Colors.grey.shade300),
//                     ),
//                     filled: true,
//                     fillColor: Colors.white,
//                     contentPadding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 14,
//                     ),
//                   ),
//                 );
//               },
//               suggestionsCallback: (pattern) =>
//                   pattern.isEmpty ? [] : _getAreaSuggestions(pattern),
//               itemBuilder: (context, suggestion) => Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   border: Border(
//                     bottom: BorderSide(color: Colors.grey.shade200),
//                   ),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(
//                       FontAwesomeIcons.locationDot,
//                       color: Theme.of(context).colorScheme.primary,
//                       size: 14,
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Text(
//                         suggestion,
//                         style: GoogleFonts.poppins(fontSize: 14),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               onSelected: (suggestion) => _searchController.text = suggestion,
//               decorationBuilder: (context, child) => Material(
//                 elevation: 12,
//                 borderRadius: BorderRadius.circular(15),
//                 child: child,
//               ),
//             ),
//           ),
//         ),

//         const SizedBox(height: 20),

//         // Improved dropdowns layout
//         LayoutBuilder(
//           builder: (context, constraints) {
//             if (constraints.maxWidth < 500) {
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
//                   const SizedBox(height: 16),
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
//               return Row(
//                 children: [
//                   Expanded(
//                     child: _buildDropdownField(
//                       label: 'Property Type',
//                       value: _selectedPropertyType,
//                       items: _propertyTypes,
//                       icon: FontAwesomeIcons.building,
//                       onChanged: (value) =>
//                           setState(() => _selectedPropertyType = value!),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
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

//         // Enhanced price range section
//         Container(
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Colors.grey.shade50,
//                 Colors.white,
//               ],
//             ),
//             borderRadius: BorderRadius.circular(15),
//             border: Border.all(color: Colors.grey.shade200),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Icon(
//                     FontAwesomeIcons.indianRupeeSign,
//                     color: Theme.of(context).colorScheme.primary,
//                     size: 16,
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     'Budget Range',
//                     style: GoogleFonts.poppins(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: const Color(0xFF333333),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   _buildPriceTag(context, _formatPrice(_priceRange.start)),
//                   _buildPriceTag(context, _formatPrice(_priceRange.end)),
//                 ],
//               ),
//               const SizedBox(height: 15),
//               SliderTheme(
//                 data: SliderTheme.of(context).copyWith(
//                   activeTrackColor: Theme.of(context).colorScheme.primary,
//                   inactiveTrackColor: Colors.grey.shade300,
//                   thumbColor: Theme.of(context).colorScheme.primary,
//                   overlayColor: Theme.of(context)
//                       .colorScheme
//                       .primary
//                       .withOpacity(0.2),
//                   thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 14),
//                   trackHeight: 6,
//                 ),
//                 child: RangeSlider(
//                   values: _priceRange,
//                   min: 100000,
//                   max: 200000000,
//                   divisions: 100,
//                   labels: RangeLabels(
//                     _formatPrice(_priceRange.start),
//                     _formatPrice(_priceRange.end),
//                   ),
//                   onChanged: (values) {
//                     setState(() => _priceRange = values);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),

//         const SizedBox(height: 24),

//         // Enhanced action buttons
//         Row(
//           children: [
//             Expanded(
//               flex: 1,
//               child: OutlinedButton.icon(
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
//                 icon: const Icon(FontAwesomeIcons.rotateLeft, size: 16),
//                 label: const Text('Clear'),
//                 style: OutlinedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   side: BorderSide(color: Colors.grey.shade400),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               flex: 2,
//               child: ElevatedButton.icon(
//                 onPressed: () {
//                   setState(() {});
//                   final count = filteredProperties.length;
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('Found $count properties matching your criteria'),
//                       backgroundColor: Theme.of(context).colorScheme.primary,
//                       behavior: SnackBarBehavior.floating,
//                     ),
//                   );
//                 },
//                 icon: const Icon(FontAwesomeIcons.magnifyingGlass, size: 16),
//                 label: const Text('SEARCH PROPERTIES'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Theme.of(context).colorScheme.primary,
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   elevation: 3,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }

// // 2. REMOVE DUPLICATES FROM LOCATION DROPDOWN - Replace the _loadProperties method:
// Future<void> _loadProperties() async {
//   setState(() => _isLoading = true);
//   try {
//     final properties = await _propertyService.fetchProperties();
//     print('Total properties fetched: ${properties.length}');

//     // Extract unique locations and REMOVE DUPLICATES
//     final uniqueLocations = <String>{};
//     for (final property in properties) {
//       final city = property['city']?.toString().trim() ?? '';
//       if (city.isNotEmpty && city != 'N/A') {
//         uniqueLocations.add(city);
//       }
//     }

//     // Convert to sorted list
//     final sortedLocations = uniqueLocations.toList()..sort();

//     setState(() {
//       _properties.clear();
//       _properties.addAll(properties);
//       _locations = ['All Locations', ...sortedLocations]; // No duplicates now
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

// // 3. ENHANCED DROPDOWN FIELD - Replace the _buildDropdownField method:
// Widget _buildDropdownField({
//   required String label,
//   required String value,
//   required List<String> items,
//   required IconData icon,
//   required ValueChanged<String?> onChanged,
// }) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Row(
//         children: [
//           Icon(
//             icon,
//             size: 14,
//             color: Theme.of(context).colorScheme.primary,
//           ),
//           const SizedBox(width: 6),
//           Text(
//             label,
//             style: GoogleFonts.poppins(
//               fontSize: 14,
//               fontWeight: FontWeight.w600,
//               color: const Color(0xFF333333),
//             ),
//           ),
//         ],
//       ),
//       const SizedBox(height: 8),
//       Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//           border: Border.all(color: Colors.grey.shade300),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               spreadRadius: 1,
//               blurRadius: 5,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<String>(
//             value: value,
//             isExpanded: true,
//             icon: Icon(
//               FontAwesomeIcons.chevronDown,
//               size: 12,
//               color: Theme.of(context).colorScheme.primary,
//             ),
//             style: GoogleFonts.poppins(
//               fontSize: 14,
//               color: const Color(0xFF333333),
//             ),
//             onChanged: onChanged,
//             items: items.map<DropdownMenuItem<String>>((String item) {
//               return DropdownMenuItem<String>(
//                 value: item,
//                 child: Row(
//                   children: [
//                     Icon(
//                       icon,
//                       size: 14,
//                       color: Theme.of(context).colorScheme.primary,
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Text(
//                         item,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     ],
//   );
// }

// // 4. ENHANCED PRICE TAG - Replace the _buildPriceTag method:
// Widget _buildPriceTag(BuildContext context, String text) {
//   return Container(
//     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//     decoration: BoxDecoration(
//       gradient: LinearGradient(
//         colors: [
//           Theme.of(context).colorScheme.primary.withOpacity(0.1),
//           Theme.of(context).colorScheme.primary.withOpacity(0.2),
//         ],
//       ),
//       borderRadius: BorderRadius.circular(25),
//       border: Border.all(
//         color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
//       ),
//     ),
//     child: Text(
//       text,
//       style: GoogleFonts.poppins(
//         fontSize: 13,
//         fontWeight: FontWeight.w700,
//         color: Theme.of(context).colorScheme.primary,
//       ),
//     ),
//   );
// }


// REPLACE YOUR _buildSearchSection() METHOD WITH THIS MAGICBRICKS STYLE:

// Widget _buildSearchSection() {
//   return Container(
//     margin: const EdgeInsets.all(16),
//     child: Column(
//       children: [
//         // Hero Section with Title
//         Container(
//           padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
//           child: Column(
//             children: [
//               RichText(
//                 textAlign: TextAlign.center,
//                 text: TextSpan(
//                   style: GoogleFonts.poppins(
//                     fontSize: 32,
//                     fontWeight: FontWeight.w600,
//                     color: const Color(0xFF333333),
//                   ),
//                   children: [
//                     const TextSpan(text: 'Find a home you\'ll '),
//                     TextSpan(
//                       text: 'love',
//                       style: GoogleFonts.dancingScript(
//                         fontSize: 36,
//                         fontWeight: FontWeight.w700,
//                         color: Theme.of(context).colorScheme.primary,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 30),
              
//               // Property Type Tabs (Buy, Rent, etc.)
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.1),
//                       spreadRadius: 1,
//                       blurRadius: 10,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     _buildTabButton('Buy', true),
//                     _buildTabButton('Rent', false),
//                     _buildTabButton('New Projects', false),
//                     _buildTabButton('PG', false),
//                     _buildTabButton('Plot', false),
//                     _buildTabButton('Commercial', false),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
              
//               // Main Search Bar - MagicBricks Style
//               Container(
//                 height: 60,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(50),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.2),
//                       spreadRadius: 2,
//                       blurRadius: 15,
//                       offset: const Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     // Location Section
//                     Expanded(
//                       flex: 3,
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         child: Row(
//                           children: [
//                             Icon(
//                               FontAwesomeIcons.locationDot,
//                               color: Theme.of(context).colorScheme.primary,
//                               size: 18,
//                             ),
//                             const SizedBox(width: 12),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     _selectedLocation == 'All Locations' 
//                                         ? 'Chennai' 
//                                         : _selectedLocation,
//                                     style: GoogleFonts.poppins(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                       color: const Color(0xFF333333),
//                                     ),
//                                   ),
//                                   GestureDetector(
//                                     onTap: _showLocationDialog,
//                                     child: Text(
//                                       'Add more...',
//                                       style: GoogleFonts.poppins(
//                                         fontSize: 12,
//                                         color: Colors.grey.shade600,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
                    
//                     // Divider
//                     Container(
//                       height: 30,
//                       width: 1,
//                       color: Colors.grey.shade300,
//                     ),
                    
//                     // Property Type Section
//                     Expanded(
//                       flex: 2,
//                       child: GestureDetector(
//                         onTap: _showPropertyTypeDialog,
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: Row(
//                             children: [
//                               Icon(
//                                 FontAwesomeIcons.home,
//                                 color: Theme.of(context).colorScheme.primary,
//                                 size: 16,
//                               ),
//                               const SizedBox(width: 12),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       _selectedPropertyType == 'All Properties'
//                                           ? 'Flat +1'
//                                           : _selectedPropertyType,
//                                       style: GoogleFonts.poppins(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500,
//                                         color: const Color(0xFF333333),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Icon(
//                                 FontAwesomeIcons.chevronDown,
//                                 size: 12,
//                                 color: Colors.grey.shade600,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
                    
//                     // Divider
//                     Container(
//                       height: 30,
//                       width: 1,
//                       color: Colors.grey.shade300,
//                     ),
                    
//                     // Budget Section
//                     Expanded(
//                       flex: 2,
//                       child: GestureDetector(
//                         onTap: _showBudgetDialog,
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: Row(
//                             children: [
//                               Icon(
//                                 FontAwesomeIcons.indianRupeeSign,
//                                 color: Theme.of(context).colorScheme.primary,
//                                 size: 16,
//                               ),
//                               const SizedBox(width: 12),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       'Budget',
//                                       style: GoogleFonts.poppins(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500,
//                                         color: const Color(0xFF333333),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Icon(
//                                 FontAwesomeIcons.chevronDown,
//                                 size: 12,
//                                 color: Colors.grey.shade600,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
                    
//                     // Search Button
//                     Container(
//                       margin: const EdgeInsets.all(5),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           setState(() {});
//                           final count = filteredProperties.length;
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: Text('Found $count properties'),
//                               backgroundColor: Theme.of(context).colorScheme.primary,
//                               behavior: SnackBarBehavior.floating,
//                             ),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Theme.of(context).colorScheme.primary,
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 30,
//                             vertical: 18,
//                           ),
//                           elevation: 0,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(25),
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             const Icon(
//                               FontAwesomeIcons.magnifyingGlass,
//                               size: 16,
//                             ),
//                             const SizedBox(width: 8),
//                             Text(
//                               'Search',
//                               style: GoogleFonts.poppins(
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }

// // ADD THESE HELPER METHODS TO YOUR CLASS:

// Widget _buildTabButton(String title, bool isActive) {
//   return Container(
//     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//     decoration: BoxDecoration(
//       color: isActive ? Theme.of(context).colorScheme.primary : Colors.transparent,
//       borderRadius: BorderRadius.circular(6),
//     ),
//     child: Text(
//       title,
//       style: GoogleFonts.poppins(
//         fontSize: 14,
//         fontWeight: FontWeight.w500,
//         color: isActive ? Colors.white : Colors.grey.shade700,
//       ),
//     ),
//   );
// }

// void _showLocationDialog() {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text(
//           'Select Location',
//           style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
//         ),
//         content: Container(
//           width: double.maxFinite,
//           height: 300,
//           child: ListView.builder(
//             itemCount: _locations.length,
//             itemBuilder: (context, index) {
//               final location = _locations[index];
//               return ListTile(
//                 leading: Icon(
//                   FontAwesomeIcons.locationDot,
//                   color: Theme.of(context).colorScheme.primary,
//                   size: 16,
//                 ),
//                 title: Text(
//                   location,
//                   style: GoogleFonts.poppins(fontSize: 14),
//                 ),
//                 onTap: () {
//                   setState(() {
//                     _selectedLocation = location;
//                   });
//                   Navigator.of(context).pop();
//                 },
//               );
//             },
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('Cancel'),
//           ),
//         ],
//       );
//     },
//   );
// }

// void _showPropertyTypeDialog() {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text(
//           'Select Property Type',
//           style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
//         ),
//         content: Container(
//           width: double.maxFinite,
//           height: 250,
//           child: ListView.builder(
//             itemCount: _propertyTypes.length,
//             itemBuilder: (context, index) {
//               final type = _propertyTypes[index];
//               return ListTile(
//                 leading: Icon(
//                   FontAwesomeIcons.building,
//                   color: Theme.of(context).colorScheme.primary,
//                   size: 16,
//                 ),
//                 title: Text(
//                   type,
//                   style: GoogleFonts.poppins(fontSize: 14),
//                 ),
//                 onTap: () {
//                   setState(() {
//                     _selectedPropertyType = type;
//                   });
//                   Navigator.of(context).pop();
//                 },
//               );
//             },
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('Cancel'),
//           ),
//         ],
//       );
//     },
//   );
// }

// void _showBudgetDialog() {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       RangeValues tempRange = _priceRange;
//       return StatefulBuilder(
//         builder: (context, setDialogState) {
//           return AlertDialog(
//             title: Text(
//               'Select Budget Range',
//               style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
//             ),
//             content: Container(
//               width: double.maxFinite,
//               height: 150,
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 12,
//                           vertical: 6,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Text(
//                           _formatPrice(tempRange.start),
//                           style: GoogleFonts.poppins(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w600,
//                             color: Theme.of(context).colorScheme.primary,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 12,
//                           vertical: 6,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Text(
//                           _formatPrice(tempRange.end),
//                           style: GoogleFonts.poppins(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w600,
//                             color: Theme.of(context).colorScheme.primary,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   SliderTheme(
//                     data: SliderTheme.of(context).copyWith(
//                       activeTrackColor: Theme.of(context).colorScheme.primary,
//                       inactiveTrackColor: Colors.grey.shade300,
//                       thumbColor: Theme.of(context).colorScheme.primary,
//                       overlayColor: Theme.of(context)
//                           .colorScheme
//                           .primary
//                           .withOpacity(0.2),
//                       thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
//                       trackHeight: 4,
//                     ),
//                     child: RangeSlider(
//                       values: tempRange,
//                       min: 100000,
//                       max: 200000000,
//                       divisions: 100,
//                       onChanged: (values) {
//                         setDialogState(() {
//                           tempRange = values;
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: const Text('Cancel'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     _priceRange = tempRange;
//                   });
//                   Navigator.of(context).pop();
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Theme.of(context).colorScheme.primary,
//                   foregroundColor: Colors.white,
//                 ),
//                 child: const Text('Apply'),
//               ),
//             ],
//           );
//         },
//       );
//     },
//   );
// }

// // RESPONSIVE MOBILE VERSION - ADD THIS METHOD:
// Widget _buildMobileSearchSection() {
//   return Container(
//     margin: const EdgeInsets.all(16),
//     child: Column(
//       children: [
//         // Hero Title
//         Container(
//           padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
//           child: RichText(
//             textAlign: TextAlign.center,
//             text: TextSpan(
//               style: GoogleFonts.poppins(
//                 fontSize: 24,
//                 fontWeight: FontWeight.w600,
//                 color: const Color(0xFF333333),
//               ),
//               children: [
//                 const TextSpan(text: 'Find a home you\'ll '),
//                 TextSpan(
//                   text: 'love',
//                   style: GoogleFonts.dancingScript(
//                     fontSize: 28,
//                     fontWeight: FontWeight.w700,
//                     color: Theme.of(context).colorScheme.primary,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
        
//         // Mobile Property Type Tabs (Scrollable)
//         Container(
//           height: 45,
//           margin: const EdgeInsets.only(bottom: 20),
//           child: ListView(
//             scrollDirection: Axis.horizontal,
//             children: [
//               _buildTabButton('Buy', true),
//               const SizedBox(width: 8),
//               _buildTabButton('Rent', false),
//               const SizedBox(width: 8),
//               _buildTabButton('New Projects', false),
//               const SizedBox(width: 8),
//               _buildTabButton('PG', false),
//               const SizedBox(width: 8),
//               _buildTabButton('Plot', false),
//               const SizedBox(width: 8),
//               _buildTabButton('Commercial', false),
//             ],
//           ),
//         ),
        
//         // Mobile Search Cards (Stacked)
//         Column(
//           children: [
//             // Location Card
//             _buildMobileSearchCard(
//               icon: FontAwesomeIcons.locationDot,
//               title: _selectedLocation == 'All Locations' ? 'Chennai' : _selectedLocation,
//               subtitle: 'Add more...',
//               onTap: _showLocationDialog,
//             ),
//             const SizedBox(height: 12),
            
//             // Property Type Card
//             _buildMobileSearchCard(
//               icon: FontAwesomeIcons.home,
//               title: _selectedPropertyType == 'All Properties' ? 'Flat +1' : _selectedPropertyType,
//               subtitle: 'Tap to change',
//               onTap: _showPropertyTypeDialog,
//             ),
//             const SizedBox(height: 12),
            
//             // Budget Card
//             _buildMobileSearchCard(
//               icon: FontAwesomeIcons.indianRupeeSign,
//               title: 'Budget',
//               subtitle: '${_formatPrice(_priceRange.start)} - ${_formatPrice(_priceRange.end)}',
//               onTap: _showBudgetDialog,
//             ),
//             const SizedBox(height: 20),
            
//             // Search Button
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: () {
//                   setState(() {});
//                   final count = filteredProperties.length;
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('Found $count properties'),
//                       backgroundColor: Theme.of(context).colorScheme.primary,
//                     ),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Theme.of(context).colorScheme.primary,
//                   foregroundColor: Colors.white,
//                   elevation: 0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(FontAwesomeIcons.magnifyingGlass, size: 16),
//                     const SizedBox(width: 8),
//                     Text(
//                       'Search Properties',
//                       style: GoogleFonts.poppins(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }

// Widget _buildMobileSearchCard({
//   required IconData icon,
//   required String title,
//   required String subtitle,
//   required VoidCallback onTap,
// }) {
//   return GestureDetector(
//     onTap: onTap,
//     child: Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade200),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Icon(
//             icon,
//             color: Theme.of(context).colorScheme.primary,
//             size: 20,
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: GoogleFonts.poppins(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: const Color(0xFF333333),
//                   ),
//                 ),
//                 Text(
//                   subtitle,
//                   style: GoogleFonts.poppins(
//                     fontSize: 12,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Icon(
//             FontAwesomeIcons.chevronRight,
//             size: 12,
//             color: Colors.grey.shade400,
//           ),
//         ],
//       ),
//     ),
//   );
// }

// UPDATE YOUR BUILD METHOD TO USE RESPONSIVE DESIGN:
// Replace the call to _buildSearchSection() in your _buildHomePage() method with:
// MediaQuery.of(context).size.width > 600 
//     ? _buildSearchSection()  // Desktop version
//     : _buildMobileSearchSection()  // Mobile version