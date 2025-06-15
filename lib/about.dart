// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class AboutUsPage extends StatelessWidget {
//   const AboutUsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Hero Section
//           FadeIn(
//             duration: const Duration(seconds: 1),
//             child: Container(
//               height: 300,
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: NetworkImage(
//                       'https://via.placeholder.com/1200x300?text=About+Our+Company'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Colors.black.withOpacity(0.1),
//                       Colors.black.withOpacity(0.7),
//                     ],
//                   ),
//                 ),
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       FadeInDown(
//                         delay: const Duration(milliseconds: 300),
//                         child: Text(
//                           'Check Dream Property',
//                           style: GoogleFonts.playfairDisplay(
//                             fontSize: 36,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       FadeInUp(
//                         delay: const Duration(milliseconds: 500),
//                         child: Container(
//                           width: 100,
//                           height: 5,
//                           decoration: BoxDecoration(
//                             color: Theme.of(context).primaryColor,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // Company Overview
//           Padding(
//             padding: const EdgeInsets.all(32.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 FadeInLeft(
//                   delay: const Duration(milliseconds: 300),
//                   child: Row(
//                     children: [
//                       Container(
//                         width: 5,
//                         height: 25,
//                         color: Theme.of(context).primaryColor,
//                       ),
//                       const SizedBox(width: 10),
//                       Text(
//                         'Our Story',
//                         style: GoogleFonts.playfairDisplay(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: const Color(0xFF333333),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 FadeInUp(
//                   delay: const Duration(milliseconds: 400),
//                   child: Text(
//                     'Established in 2005, YourCompanyName has been a trusted name in the Tamil Nadu real estate market for over 20 years. We started with a simple mission: to help people find their dream homes and make profitable real estate investments in the beautiful state of Tamil Nadu.',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey.shade700,
//                       height: 1.6,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//                 FadeInUp(
//                   delay: const Duration(milliseconds: 500),
//                   child: Text(
//                     'What began as a small office in Chennai has now expanded to multiple branches across major cities in Tamil Nadu. Our growth is a testament to our commitment to customer satisfaction and our deep understanding of the local real estate market.',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey.shade700,
//                       height: 1.6,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                 FadeInLeft(
//                   delay: const Duration(milliseconds: 600),
//                   child: Row(
//                     children: [
//                       Container(
//                         width: 5,
//                         height: 25,
//                         color: Theme.of(context).primaryColor,
//                       ),
//                       const SizedBox(width: 10),
//                       Text(
//                         'Our Values',
//                         style: GoogleFonts.playfairDisplay(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: const Color(0xFF333333),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 FadeInUp(
//                   delay: const Duration(milliseconds: 700),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: _buildValueCard(
//                           context,
//                           Icons.verified_user,
//                           'Trust & Integrity',
//                           'We believe in transparent dealings and building long-term relationships based on trust.',
//                         ),
//                       ),
//                       const SizedBox(width: 20),
//                       Expanded(
//                         child: _buildValueCard(
//                           context,
//                           Icons.thumb_up,
//                           'Excellence',
//                           'We strive for excellence in every aspect of our service, from property selection to after-sales support.',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 FadeInUp(
//                   delay: const Duration(milliseconds: 800),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: _buildValueCard(
//                           context,
//                           Icons.groups,
//                           'Customer First',
//                           'We put our customers needs and satisfaction at the center of everything we do.',
//                         ),
//                       ),
//                       const SizedBox(width: 20),
//                       Expanded(
//                         child: _buildValueCard(
//                           context,
//                           Icons.trending_up,
//                           'Innovation',
//                           'We continuously innovate and adopt the latest technologies to enhance our services.',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                 FadeInLeft(
//                   delay: const Duration(milliseconds: 900),
//                   child: Row(
//                     children: [
//                       Container(
//                         width: 5,
//                         height: 25,
//                         color: Theme.of(context).primaryColor,
//                       ),
//                       const SizedBox(width: 10),
//                       Text(
//                         'Our Team',
//                         style: GoogleFonts.playfairDisplay(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: const Color(0xFF333333),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 FadeInUp(
//                   delay: const Duration(milliseconds: 1000),
//                   child: Text(
//                     'Our team consists of experienced real estate professionals who understand the Tamil Nadu property market inside out. Each member brings unique expertise, whether its in property valuation, legal matters, or customer service. Together, we work cohesively to provide you with a seamless real estate experience.',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey.shade700,
//                       height: 1.6,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 FadeInUp(
//                   delay: const Duration(milliseconds: 1100),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       _buildTeamMember(
//                         'https://via.placeholder.com/150?text=CEO',
//                         'John Doe',
//                         'CEO & Founder',
//                       ),
//                       const SizedBox(width: 30),
//                       _buildTeamMember(
//                         'https://via.placeholder.com/150?text=COO',
//                         'Jane Smith',
//                         'Chief Operations Officer',
//                       ),
//                       const SizedBox(width: 30),
//                       _buildTeamMember(
//                         'https://via.placeholder.com/150?text=Sales',
//                         'Michael Johnson',
//                         'Head of Sales',
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Call to Action
//           FadeIn(
//             duration: const Duration(seconds: 1),
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 40),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).primaryColor.withOpacity(0.1),
//               ),
//               child: Center(
//                 child: Column(
//                   children: [
//                     Text(
//                       'Ready to Find Your Dream Property?',
//                       style: GoogleFonts.playfairDisplay(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: const Color(0xFF333333),
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Theme.of(context).primaryColor,
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 30, vertical: 15),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                       child: const Text('Contact Us Today'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildValueCard(
//       BuildContext context, IconData icon, String title, String description) {
//     return Card(
//       elevation: 3,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CircleAvatar(
//               backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
//               radius: 25,
//               child: Icon(
//                 icon,
//                 color: Theme.of(context).primaryColor,
//                 size: 24,
//               ),
//             ),
//             const SizedBox(height: 15),
//             Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               description,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey.shade700,
//                 height: 1.5,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTeamMember(String imageUrl, String name, String position) {
//     return Column(
//       children: [
//         CircleAvatar(
//           backgroundImage: NetworkImage(imageUrl),
//           radius: 50,
//         ),
//         const SizedBox(height: 10),
//         Text(
//           name,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 5),
//         Text(
//           position,
//           style: TextStyle(
//             fontSize: 14,
//             color: Colors.grey.shade600,
//           ),
//         ),
//       ],
//     );
//   }
// }

