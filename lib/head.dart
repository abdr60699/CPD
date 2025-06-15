// Widget _buildHeroSection() {
//   return FadeIn(
//     duration: const Duration(seconds: 1),
//     child: Container(
//       height: 400,
//       width: double.infinity,
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//           image: NetworkImage(
//               'https://via.placeholder.com/1200x400?text=Beautiful+Tamil+Nadu+Properties'),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Colors.black.withOpacity(0.1),
//               Colors.black.withOpacity(0.7),
//             ],
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               FadeInDown(
//                 delay: const Duration(milliseconds: 300),
//                 child: Text(
//                   'Find Your Dream Property in Tamil Nadu',
//                   style: GoogleFonts.playfairDisplay(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               FadeInUp(
//                 delay: const Duration(milliseconds: 500),
//                 child: Container(
//                   width: 100,
//                   height: 5,
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).colorScheme.primary,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               FadeInUp(
//                 delay: const Duration(milliseconds: 700),
//                 child: Text(
//                   'Trusted Real Estate Solutions Since 2005',
//                   style: GoogleFonts.poppins(
//                     fontSize: 16,
//                     color: Colors.white,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

PreferredSizeWidget buildResponsiveAppBar(
    BuildContext context, int selectedIndex, Function(int) onItemSelected) {
  final isMobile = MediaQuery.of(context).size.width < 600;

  return AppBar(
    surfaceTintColor: Colors.transparent,
    backgroundColor: Colors.white,
    elevation: 0,
    title: Row(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(
              "https://raw.githubusercontent.com/abdr60699/CPD/main/ChatGPT%20Image%20Jun%206,%202025,%2009_30_07%20PM.png",
            ),
            maxRadius: 25,
          ),
        ),
        Text(
          'Check Dream Property',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    ),
    // actions: isMobile
    //     ? [
    //         PopupMenuButton<int>(

    //           icon: Icon(Icons.menu,
    //               color: Theme.of(context).colorScheme.primary),
    //           onSelected: onItemSelected,
    //           itemBuilder: (context) => [
    //             // const PopupMenuItem(value: 0, child: Text('Home')),
    //             // const PopupMenuItem(value: 1, child: Text('About Us')),
    //             const PopupMenuItem(value: 2, child: Text('Contact')),
    //           ],
    //         ),
    //       ]
    //     : [
    //         // _buildNavItem(context, 'Home', 0, selectedIndex, onItemSelected),
    //         // _buildNavItem(context, 'About Us', 1, selectedIndex, onItemSelected),
    //         // _buildNavItem(context, 'Contact', 2, selectedIndex, onItemSelected),
    //         const SizedBox(width: 20),
    //       ],
  );
}

Widget _buildNavItem(BuildContext context, String title, int index,
    int selectedIndex, Function(int) onTap) {
  return TextButton(
    onPressed: () => onTap(index),
    child: Text(
      title,
      style: TextStyle(
        color: selectedIndex == index
            ? Theme.of(context).colorScheme.primary
            : Colors.grey.shade700,
        fontWeight:
            selectedIndex == index ? FontWeight.bold : FontWeight.normal,
      ),
    ),
  );
}
