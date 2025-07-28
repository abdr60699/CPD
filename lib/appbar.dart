import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'utils/web_utils.dart';

PreferredSizeWidget buildResponsiveAppBar(
    BuildContext context, int selectedIndex, Function(int) onItemSelected) {
  final isMobile = MediaQuery.of(context).size.width < 600;

  return AppBar(
    surfaceTintColor: Colors.transparent,
    backgroundColor: Colors.white,
    elevation: 4,
    title: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              reloadPage();
            },
            child: SizedBox(
              width: 50,
              height: 50,
              child: ClipOval(
                child: Image.network(
                  "https://raw.githubusercontent.com/abdr60699/CPD/e8f1fe2d19cb7633020de7476723acc895eca6de/ChatGPT%20Image%20Jun%2021%2C%202025%2C%2002_03_46%20PM.png",
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error, color: Colors.red),
                ),
              ),
            ),
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
