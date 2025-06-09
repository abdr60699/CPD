import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';


class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Section
          FadeIn(
            duration: const Duration(seconds: 1),
            child: Container(
              height: 250,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://via.placeholder.com/1200x250?text=Contact+Us'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeInDown(
                        delay: const Duration(milliseconds: 300),
                        child: Text(
                          'Get in Touch',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20),
                      FadeInUp(
                        delay: const Duration(milliseconds: 500),
                        child: Container(
                          width: 100,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      FadeInUp(
                        delay: const Duration(milliseconds: 700),
                        child: Text(
                          'Were Here to Help You',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Contact Information and Form
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Contact Information
                Expanded(
                  flex: 2,
                  child: FadeInLeft(
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Contact Information',
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF333333),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: 50,
                              height: 3,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(height: 25),
                            _buildContactInfo(
                              context,
                              Icons.location_on,
                              'Office Address',
                              '123 Anna Salai, Chennai,\nTamil Nadu - 600002',
                            ),
                            const SizedBox(height: 20),
                            _buildContactInfo(
                              context,
                              Icons.phone,
                              'Phone Number',
                              '+91 98765 43210\n+91 98765 43211',
                            ),
                            const SizedBox(height: 20),
                            _buildContactInfo(
                              context,
                              Icons.email,
                              'Email Address',
                              'info@yourcompany.com\nsupport@yourcompany.com',
                            ),
                            const SizedBox(height: 20),
                            _buildContactInfo(
                              context,
                              Icons.access_time,
                              'Working Hours',
                              'Monday - Saturday: 9:00 AM - 7:00 PM\nSunday: Closed',
                            ),
                            const SizedBox(height: 30),
                            Text(
                              'Follow Us',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                _buildSocialIcon(
                                    FontAwesomeIcons.facebook, Colors.blue),
                                const SizedBox(width: 15),
                                _buildSocialIcon(
                                    FontAwesomeIcons.twitter, Colors.lightBlue),
                                const SizedBox(width: 15),
                                _buildSocialIcon(
                                    FontAwesomeIcons.instagram, Colors.purple),
                                const SizedBox(width: 15),
                                _buildSocialIcon(FontAwesomeIcons.linkedin,
                                    Colors.blueAccent),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 30),

                // Contact Form
                Expanded(
                  flex: 3,
                  child: FadeInRight(
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Send a Message',
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF333333),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: 50,
                              height: 3,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(height: 25),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Full Name',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      prefixIcon: const Icon(Icons.person),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Email Address',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      prefixIcon: const Icon(Icons.email),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Phone Number',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      prefixIcon: const Icon(Icons.phone),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Subject',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      prefixIcon: const Icon(Icons.subject),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            TextField(
                              maxLines: 5,
                              decoration: InputDecoration(
                                labelText: 'Your Message',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignLabelWithHint: true,
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Message sent successfully! We\'ll get back to you soon.'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'SEND MESSAGE',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Map Section
          FadeIn(
            duration: const Duration(seconds: 1),
            child: Container(
              height: 400,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://via.placeholder.com/1200x400?text=Google+Map+Location'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Regional Offices
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInLeft(
                  child: Text(
                    'Our Regional Offices',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF333333),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                FadeInLeft(
                  child: Container(
                    width: 70,
                    height: 3,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 30),
                FadeInUp(
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildOfficeCard(
                          context,
                          'Chennai Office',
                          '123 Anna Salai, Chennai,\nTamil Nadu - 600002',
                          '+91 98765 43210',
                          'chennai@yourcompany.com',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildOfficeCard(
                          context,
                          'Coimbatore Office',
                          '456 Avinashi Road, Coimbatore,\nTamil Nadu - 641004',
                          '+91 98765 43212',
                          'coimbatore@yourcompany.com',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildOfficeCard(
                          context,
                          'Madurai Office',
                          '789 North Veli Street, Madurai,\nTamil Nadu - 625001',
                          '+91 98765 43213',
                          'madurai@yourcompany.com',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Footer (optional)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            color: const Color(0xFF333333),
            child: Center(
              child: Text(
                '© ${DateTime.now().year} YourCompanyName. All Rights Reserved.',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(
      BuildContext context, IconData icon, String title, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
          radius: 25,
          child: Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 24,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                content,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color) {
    return InkWell(
      onTap: () {},
      child: CircleAvatar(
        backgroundColor: color.withOpacity(0.1),
        radius: 20,
        child: FaIcon(
          icon,
          color: color,
          size: 18,
        ),
      ),
    );
  }

  Widget _buildOfficeCard(BuildContext context, String title, String address,
      String phone, String email) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 40,
              height: 2,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.grey.shade700),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    address,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.phone, size: 16, color: Colors.grey.shade700),
                const SizedBox(width: 10),
                Text(
                  phone,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.email, size: 16, color: Colors.grey.shade700),
                const SizedBox(width: 10),
                Text(
                  email,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}