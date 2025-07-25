import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

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
                              'https://images.unsplash.com/photo-1690900257842-f78779d310cd?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8ZW1wdHklMjBsYW5kJTIwcGljdHVyZXMlMjBmb3IlMjBidWlsZGluZyUyMGluJTIwaW5kaWF8ZW58MHx8MHx8fDA%3D',
                  ),
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
                            fontSize: 32,
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
                          width: 80,
                          height: 4,
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
                          "We're Here to Help You",
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
            padding: const EdgeInsets.all(16.0),
            child: isMobile
                ? Column(
                    children: [
                      _buildContactCard(context),
                      const SizedBox(height: 20),
                      // _buildFormCard(context),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: _buildContactCard(context)),
                      const SizedBox(width: 20),
                      // Expanded(flex: 3, child: _buildFormCard(context)),
                    ],
                  ),
          ),

          // Footer
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            color: const Color(0xFF333333),
            child: Center(
              child: Text(
                '© ${DateTime.now().year} Check Dream Property.',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(BuildContext context) {
    return FadeInLeft(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
            // _buildContactInfo(context, Icons.location_on, 'Office Address',
            //     '123 Anna Salai, Chennai,\nTamil Nadu - 600002'),
            // const SizedBox(height: 20),
            _buildContactInfo(
                context, Icons.phone, 'Phone Number', '+91 7401399181'),
            const SizedBox(height: 20),
            _buildContactInfo(context, Icons.email, 'Email Address',
                'checkdreamproperties@gmail.com'),
            // const SizedBox(height: 20),
            // // _buildContactInfo(context, Icons.access_time, 'Working Hours',
            // //     'Mon - Sat: 9:00 AM - 7:00 PM\nSunday: Closed'),
            // const SizedBox(height: 30),
            // Text('Follow Us',
            //     style: GoogleFonts.poppins(
            //         fontSize: 18, fontWeight: FontWeight.bold)),
            // const SizedBox(height: 15),
            // Row(
            //   children: [
            //     _buildSocialIcon(FontAwesomeIcons.facebook, Colors.blue),
            //     const SizedBox(width: 10),
            //     _buildSocialIcon(FontAwesomeIcons.twitter, Colors.lightBlue),
            //     const SizedBox(width: 10),
            //     _buildSocialIcon(FontAwesomeIcons.instagram, Colors.purple),
            //     const SizedBox(width: 10),
            //     _buildSocialIcon(
            //         FontAwesomeIcons.linkedin, Colors.blueAccent),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormCard(BuildContext context) {
    return FadeInRight(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
              Wrap(
                spacing: 15,
                runSpacing: 15,
                children: [
                  SizedBox(
                    width: 300,
                    child: _buildInputField('Full Name', Icons.person),
                  ),
                  SizedBox(
                    width: 300,
                    child: _buildInputField('Email Address', Icons.email),
                  ),
                  SizedBox(
                    width: 300,
                    child: _buildInputField('Phone Number', Icons.phone),
                  ),
                  SizedBox(
                    width: 300,
                    child: _buildInputField('Subject', Icons.subject),
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
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'SEND MESSAGE',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
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
          child: Icon(icon, color: Theme.of(context).primaryColor, size: 24),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(content,
                  style: TextStyle(
                      fontSize: 14, color: Colors.grey.shade700, height: 1.5)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInputField(String label, IconData icon) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        prefixIcon: Icon(icon),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color) {
    return InkWell(
      onTap: () {},
      child: CircleAvatar(
        backgroundColor: color.withOpacity(0.1),
        radius: 20,
        child: FaIcon(icon, color: color, size: 18),
      ),
    );
  }
}
