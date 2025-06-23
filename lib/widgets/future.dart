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
