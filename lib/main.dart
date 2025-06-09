import 'package:animate_do/animate_do.dart';
import 'package:checkdreamproperty/about.dart';
import 'package:checkdreamproperty/contact.dart';
import 'package:checkdreamproperty/head.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

void main() {
  runApp(const RealEstateApp());
}

class RealEstateApp extends StatelessWidget {
  const RealEstateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Check Dream Property',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFFF6B00), // Orange
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromRGBO(239, 131, 23, 1),
          secondary: const Color(0xFF333333),
          background: Colors.white,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  String _selectedPropertyType = 'All Properties';
  String _selectedLocation = 'All Locations';
  RangeValues _priceRange = const RangeValues(1000000, 10000000);

  final List<String> _propertyTypes = [
    'All Properties',
    'Apartment',
    'Villa',
    'Plot',
    'Commercial'
  ];

  final List<String> _locations = [
    'All Locations',
    'Chennai',
    'Coimbatore',
    'Madurai',
    'Salem',
    'Tiruppur'
  ];

  final List<Map<String, dynamic>> _properties = [
    {
      'id': 1,
      'title': 'Premium Villa in Velachery',
      'type': 'Villa',
      'location': 'Velachery, Chennai',
      'price': 8500000,
      'squareFeet': 2400,
      'grounds': 2.5,
      'builtupArea': 2200,
      'landmark': 'Near Phoenix Mall',
      'mapLink': 'https://maps.google.com/?q=Velachery,Chennai',
      'waterTax': 5000,
      'propertyTax': 15000,
      'city': 'Chennai',
      'bedrooms': 3,
      'bathrooms': 3,
      'ageYears': 2,
      'forRent': false,
      'rentAmount': 0,
      'images': [
        'https://images.unsplash.com/photo-1690900257842-f78779d310cd?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8ZW1wdHklMjBsYW5kJTIwcGljdHVyZXMlMjBmb3IlMjBidWlsZGluZyUyMGluJTIwaW5kaWF8ZW58MHx8MHx8fDA%3D',
        'https://images.unsplash.com/photo-1630240976913-ce903373e752?q=80&w=1926&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'https://images.unsplash.com/photo-1649663891220-1bff96da78b2?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGVtcHR5JTIwbGFuZCUyMHBpY3R1cmVzJTIwZm9yJTIwYnVpbGRpbmclMjBpbiUyMGluZGlhfGVufDB8fDB8fHww',
        "https://www.youtube.com/watch?v=if9mboENc74"
      ],
      'contact': {'phone': '+919876543210', 'whatsapp': '+919876543210'}
    },
    {
      'id': 2,
      'title': '3BHK Apartment in Adyar',
      'type': 'Apartment',
      'location': 'Adyar, Chennai',
      'price': 6500000,
      'squareFeet': 1500,
      'grounds': 0,
      'builtupArea': 1450,
      'landmark': 'Near Adyar Signal',
      'mapLink': '',
      'waterTax': 3500,
      'propertyTax': 12000,
      'city': 'Chennai',
      'bedrooms': 3,
      'bathrooms': 2,
      'ageYears': 5,
      'forRent': false,
      'rentAmount': 0,
      'images': [
        'https://images.unsplash.com/photo-1690900257842-f78779d310cd?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8ZW1wdHklMjBsYW5kJTIwcGljdHVyZXMlMjBmb3IlMjBidWlsZGluZyUyMGluJTIwaW5kaWF8ZW58MHx8MHx8fDA%3D',
        'https://images.unsplash.com/photo-1630240976913-ce903373e752?q=80&w=1926&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'https://images.unsplash.com/photo-1649663891220-1bff96da78b2?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGVtcHR5JTIwbGFuZCUyMHBpY3R1cmVzJTIwZm9yJTIwYnVpbGRpbmclMjBpbiUyMGluZGlhfGVufDB8fDB8fHww'
      ],
      'contact': {'phone': '+919876543211', 'whatsapp': '+919876543211'}
    },
    {
      'id': 3,
      'title': 'Commercial Space in T. Nagar',
      'type': 'Commercial',
      'location': 'T. Nagar, Chennai',
      'price': 15000000,
      'squareFeet': 3500,
      'grounds': 1.8,
      'builtupArea': 3400,
      'landmark': 'Near Panagal Park',
      'mapLink': 'https://maps.google.com/?q=T.Nagar,Chennai',
      'waterTax': 8500,
      'propertyTax': 35000,
      'city': 'Chennai',
      'bedrooms': 0,
      'bathrooms': 4,
      'ageYears': 1,
      'forRent': false,
      'rentAmount': 0,
      'images': [
        'https://images.unsplash.com/photo-1690900257842-f78779d310cd?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8ZW1wdHklMjBsYW5kJTIwcGljdHVyZXMlMjBmb3IlMjBidWlsZGluZyUyMGluJTIwaW5kaWF8ZW58MHx8MHx8fDA%3D',
        'https://images.unsplash.com/photo-1630240976913-ce903373e752?q=80&w=1926&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'https://images.unsplash.com/photo-1649663891220-1bff96da78b2?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGVtcHR5JTIwbGFuZCUyMHBpY3R1cmVzJTIwZm9yJTIwYnVpbGRpbmclMjBpbiUyMGluZGlhfGVufDB8fDB8fHww'
      ],
      'contact': {'phone': '+919876543212', 'whatsapp': '+919876543212'}
    },
    {
      'id': 4,
      'title': '2BHK Rental Apartment in OMR',
      'type': 'Apartment',
      'location': 'OMR, Chennai',
      'price': 0,
      'squareFeet': 1200,
      'grounds': 0,
      'builtupArea': 1150,
      'landmark': 'Near Thoraipakkam',
      'mapLink': 'https://maps.google.com/?q=OMR,Chennai',
      'waterTax': 2500,
      'propertyTax': 8000,
      'city': 'Chennai',
      'bedrooms': 2,
      'bathrooms': 2,
      'ageYears': 3,
      'forRent': true,
      'rentAmount': 25000,
      'images': [
        'https://images.unsplash.com/photo-1690900257842-f78779d310cd?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8ZW1wdHklMjBsYW5kJTIwcGljdHVyZXMlMjBmb3IlMjBidWlsZGluZyUyMGluJTIwaW5kaWF8ZW58MHx8MHx8fDA%3D',
        'https://images.unsplash.com/photo-1630240976913-ce903373e752?q=80&w=1926&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'https://images.unsplash.com/photo-1649663891220-1bff96da78b2?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGVtcHR5JTIwbGFuZCUyMHBpY3R1cmVzJTIwZm9yJTIwYnVpbGRpbmclMjBpbiUyMGluZGlhfGVufDB8fDB8fHww'
      ],
      'contact': {'phone': '+919876543213', 'whatsapp': '+919876543213'}
    },
    {
      'id': 5,
      'title': 'Premium Plot in Coimbatore',
      'type': 'Plot',
      'location': 'Saravanampatti, Coimbatore',
      'price': 4500000,
      'squareFeet': 4800,
      'grounds': 4.0,
      'builtupArea': 0,
      'landmark': 'Near IT Park',
      'mapLink': 'https://maps.google.com/?q=Saravanampatti,Coimbatore',
      'waterTax': 0,
      'propertyTax': 8500,
      'city': 'Coimbatore',
      'bedrooms': 0,
      'bathrooms': 0,
      'ageYears': 0,
      'forRent': false,
      'rentAmount': 0,
      'images': [
        'https://images.unsplash.com/photo-1690900257842-f78779d310cd?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8ZW1wdHklMjBsYW5kJTIwcGljdHVyZXMlMjBmb3IlMjBidWlsZGluZyUyMGluJTIwaW5kaWF8ZW58MHx8MHx8fDA%3D',
        'https://images.unsplash.com/photo-1630240976913-ce903373e752?q=80&w=1926&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'https://images.unsplash.com/photo-1649663891220-1bff96da78b2?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGVtcHR5JTIwbGFuZCUyMHBpY3R1cmVzJTIwZm9yJTIwYnVpbGRpbmclMjBpbiUyMGluZGlhfGVufDB8fDB8fHww'
      ],
      'contact': {'phone': '+919876543214', 'whatsapp': '+919876543214'}
    },
    {
      'id': 7,
      'title': 'Premium Plot in Selem',
      'type': 'Plot',
      'location': 'Saravanampatti, Selem',
      'price': 4500000,
      'squareFeet': 4800,
      'grounds': 4.0,
      'builtupArea': 0,
      'landmark': 'Near IT Park',
      'mapLink': 'https://maps.google.com/?q=Saravanampatti,Selem',
      'waterTax': 0,
      'propertyTax': 8500,
      'city': 'Coimbatore',
      'bedrooms': 0,
      'bathrooms': 0,
      'ageYears': 0,
      'forRent': false,
      'rentAmount': 0,
      'images': [
        'https://images.unsplash.com/photo-1690900257842-f78779d310cd?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8ZW1wdHklMjBsYW5kJTIwcGljdHVyZXMlMjBmb3IlMjBidWlsZGluZyUyMGluJTIwaW5kaWF8ZW58MHx8MHx8fDA%3D',
        'https://images.unsplash.com/photo-1630240976913-ce903373e752?q=80&w=1926&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'https://images.unsplash.com/photo-1649663891220-1bff96da78b2?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGVtcHR5JTIwbGFuZCUyMHBpY3R1cmVzJTIwZm9yJTIwYnVpbGRpbmclMjBpbiUyMGluZGlhfGVufDB8fDB8fHww'
      ],
      'contact': {'phone': '+919876543214', 'whatsapp': '+919876543214'}
    },
    {
      'id': 8,
      'title': 'Premium Plot in Coimbatore',
      'type': 'Plot',
      'location': 'Saravanampatti, Coimbatore',
      'price': 4500000,
      'squareFeet': 4800,
      'grounds': 4.0,
      'builtupArea': 0,
      'landmark': 'Near IT Park',
      'mapLink': 'https://maps.google.com/?q=Saravanampatti,Coimbatore',
      'waterTax': 0,
      'propertyTax': 8500,
      'city': 'Coimbatore',
      'bedrooms': 0,
      'bathrooms': 0,
      'ageYears': 0,
      'forRent': false,
      'rentAmount': 0,
      'images': [
        'https://images.unsplash.com/photo-1690900257842-f78779d310cd?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8ZW1wdHklMjBsYW5kJTIwcGljdHVyZXMlMjBmb3IlMjBidWlsZGluZyUyMGluJTIwaW5kaWF8ZW58MHx8MHx8fDA%3D',
        'https://images.unsplash.com/photo-1630240976913-ce903373e752?q=80&w=1926&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'https://images.unsplash.com/photo-1649663891220-1bff96da78b2?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGVtcHR5JTIwbGFuZCUyMHBpY3R1cmVzJTIwZm9yJTIwYnVpbGRpbmclMjBpbiUyMGluZGlhfGVufDB8fDB8fHww'
      ],
      'contact': {'phone': '+919876543214', 'whatsapp': '+919876543214'}
    },
    {
      'id': 9,
      'title': 'Premium Plot in Coimbatore',
      'type': 'Plot',
      'location': 'Saravanampatti, Coimbatore',
      'price': 4500000,
      'squareFeet': 4800,
      'grounds': 4.0,
      'builtupArea': 0,
      'landmark': 'Near IT Park',
      'mapLink': '',
      'waterTax': 0,
      'propertyTax': 8500,
      'city': 'Coimbatore',
      'bedrooms': 0,
      'bathrooms': 0,
      'ageYears': 0,
      'forRent': false,
      'rentAmount': 0,
      'images': [
        'https://images.unsplash.com/photo-1690900257842-f78779d310cd?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8ZW1wdHklMjBsYW5kJTIwcGljdHVyZXMlMjBmb3IlMjBidWlsZGluZyUyMGluJTIwaW5kaWF8ZW58MHx8MHx8fDA%3D',
        'https://images.unsplash.com/photo-1630240976913-ce903373e752?q=80&w=1926&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'https://images.unsplash.com/photo-1649663891220-1bff96da78b2?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGVtcHR5JTIwbGFuZCUyMHBpY3R1cmVzJTIwZm9yJTIwYnVpbGRpbmclMjBpbiUyMGluZGlhfGVufDB8fDB8fHww'
      ],
      'contact': {'phone': '+919876543214', 'whatsapp': '+919876543214'}
    },
  ];

  List<Map<String, dynamic>> get filteredProperties {
    return _properties.where((property) {
      final matchesType = _selectedPropertyType == 'All Properties' ||
          property['type'] == _selectedPropertyType;
      final matchesLocation = _selectedLocation == 'All Locations' ||
          property['city'] == _selectedLocation;
      final price =
          property['forRent'] ? property['rentAmount'] : property['price'];
      final matchesPrice =
          price >= _priceRange.start && price <= _priceRange.end;

      return matchesType && matchesLocation && matchesPrice;
    }).toList();
  }

  List<String> _getAreaSuggestions(String query) {
    List<String> areas = [
      'Velachery, Chennai',
      'Adyar, Chennai',
      'T. Nagar, Chennai',
      'Anna Nagar, Chennai',
      'Porur, Chennai',
      'Tambaram, Chennai',
      'OMR, Chennai',
      'ECR, Chennai',
      'Perungudi, Chennai',
      'Saravanampatti, Coimbatore',
      'RS Puram, Coimbatore',
      'Singanallur, Coimbatore',
      'K.K. Nagar, Madurai',
      'Chokkikulam, Madurai',
      'Suramangalam, Salem',
      'Avinashi Road, Tiruppur'
    ];

    return areas
        .where((area) => area.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch URL')),
        );
      }
    }
  }

  void _callPhone(String phoneNumber) {
    _launchURL('tel:$phoneNumber');
  }

  void _openWhatsApp(String phoneNumber) {
    _launchURL('https://wa.me/$phoneNumber');
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomePage();
      case 1:
        return const AboutUsPage();
      case 2:
        return const ContactUsPage();
      default:
        return _buildHomePage();
    }
  }

  Widget _buildPriceTag(BuildContext context, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildHomePage() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // _buildHeroSection(),
          _buildSearchSection(),
          _buildFeaturedProperties(),
        ],
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Find Your Perfect Property',
            style: GoogleFonts.playfairDisplay(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Filter by location, type & budget',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),

          /// 🔍 Search Field
          _buildSearchField(
            child: TypeAheadField<String>(
              controller: _searchController,
              builder: (context, controller, focusNode) {
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  style: GoogleFonts.poppins(fontSize: 14),
                  decoration: InputDecoration(
                    labelText: 'Search Location',
                    labelStyle:
                        const TextStyle(color: Color(0xFF333333), fontSize: 14),
                    hintText: 'e.g., Velachery, Chennai',
                    prefixIcon: Icon(
                      FontAwesomeIcons.locationDot,
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
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
                      horizontal: 20,
                      vertical: 16,
                    ),
                  ),
                );
              },
              suggestionsCallback: (pattern) =>
                  pattern.isEmpty ? [] : _getAreaSuggestions(pattern),
              itemBuilder: (context, suggestion) => Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.locationDot,
                        color: Theme.of(context).colorScheme.primary, size: 14),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        suggestion,
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              onSelected: (suggestion) => _searchController.text = suggestion,
              decorationBuilder: (context, child) => Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(12),
                child: child,
              ),
            ),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 360;

              if (isNarrow) {
                // Stack in Column on very small screens
                return Column(
                  children: [
                    _buildDropdownField(
                      label: 'Property Type',
                      value: _selectedPropertyType,
                      items: _propertyTypes,
                      icon: FontAwesomeIcons.building,
                      onChanged: (value) =>
                          setState(() => _selectedPropertyType = value!),
                    ),
                    const SizedBox(height: 12),
                    _buildDropdownField(
                      label: 'City',
                      value: _selectedLocation,
                      items: _locations,
                      icon: FontAwesomeIcons.city,
                      onChanged: (value) =>
                          setState(() => _selectedLocation = value!),
                    ),
                  ],
                );
              } else {
                // Regular Row for wider screens
                return Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: _buildDropdownField(
                        label: 'Property Type',
                        value: _selectedPropertyType,
                        items: _propertyTypes,
                        icon: FontAwesomeIcons.building,
                        onChanged: (value) =>
                            setState(() => _selectedPropertyType = value!),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Flexible(
                      flex: 1,
                      child: _buildDropdownField(
                        label: 'City',
                        value: _selectedLocation,
                        items: _locations,
                        icon: FontAwesomeIcons.city,
                        onChanged: (value) =>
                            setState(() => _selectedLocation = value!),
                      ),
                    ),
                  ],
                );
              }
            },
          ),

          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.indianRupeeSign,
                      color: Theme.of(context).colorScheme.primary,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Budget Range',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildPriceTag(context,
                          '₹${(_priceRange.start / 100000).toStringAsFixed(1)} L'),
                      _buildPriceTag(context,
                          '₹${(_priceRange.end / 100000).toStringAsFixed(1)} L'),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Theme.of(context).colorScheme.primary,
                      inactiveTrackColor: Colors.grey.shade300,
                      thumbColor: Theme.of(context).colorScheme.primary,
                      overlayColor: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.2),
                      thumbShape:
                          const RoundSliderThumbShape(enabledThumbRadius: 12),
                      trackHeight: 4,
                    ),
                    child: RangeSlider(
                      values: _priceRange,
                      min: 100000, // ₹1 Lac
                      max: 200000000, // ₹50 Crores
                      divisions:
                          100, // ~₹5L steps (you can increase for finer control)
                      labels: RangeLabels(
                        '₹${(_priceRange.start / 100000).toStringAsFixed(1)} L',
                        '₹${(_priceRange.end / 200000000).toStringAsFixed(1)} Cr',
                      ),
                      onChanged: (values) =>
                          setState(() => _priceRange = values),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                      _selectedPropertyType = 'All Properties';
                      _selectedLocation = 'All Locations';
                      _priceRange = const RangeValues(1000000, 10000000);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Filters cleared'),
                        backgroundColor: Colors.grey[700],
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: Colors.grey.shade400),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.rotateLeft,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Clear',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      // Apply filters
                    });

                    final count = filteredProperties.length;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Found $count properties matching your criteria'),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        behavior: SnackBarBehavior.floating,
                        action: count > 0
                            ? SnackBarAction(
                                label: 'View',
                                textColor: Colors.white,
                                onPressed: () {
                                  // Scroll to section
                                },
                              )
                            : null,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(FontAwesomeIcons.magnifyingGlass, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        'SEARCH PROPERTIES',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField({required Widget child}) {
    return child;
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required IconData icon,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: Icon(
                FontAwesomeIcons.chevronDown,
                size: 12,
                color: Colors.grey[600],
              ),
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFF333333),
              ),
              onChanged: onChanged,
              items: items.map<DropdownMenuItem<String>>((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Row(
                    children: [
                      Icon(
                        icon,
                        size: 14,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 12),
                      Text(item),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedProperties() {
    if (filteredProperties.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              const Icon(Icons.search_off, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              Text(
                'No properties found matching your criteria',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade700,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: FadeInLeft(
                  child: Text(
                    'Featured Properties',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF333333),
                    ),
                  ),
                ),
              ),
              FadeInRight(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'View All',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // Mobile-first responsive grid
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth > 600;
              int crossAxisCount = 1;
              if (constraints.maxWidth > 600) {
                crossAxisCount = 2;
              }
              if (constraints.maxWidth > 900) {
                crossAxisCount = 3;
              }

              return MasonryGridView.count(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredProperties.length,
                itemBuilder: (context, index) {
                  final property = filteredProperties[index];
                  return FadeInUp(
                    delay: Duration(milliseconds: 100 * index),
                    child: PropertyCard(
                      isMobile: isMobile,
                      property: property,
                      onPhonePressed: () =>
                          _callPhone(property['contact']['phone']),
                      onWhatsAppPressed: () =>
                          _openWhatsApp(property['contact']['whatsapp']),
                      onMapPressed: () => _launchURL(property['mapLink']),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildResponsiveAppBar(context, _selectedIndex, (index) {
        setState(() {
          _selectedIndex = index;
        });
      }),
      body: _buildBody(),
    );
  }
}

class ImageGalleryPreview extends StatefulWidget {
  final List<String> images;

  const ImageGalleryPreview({super.key, required this.images});

  @override
  State<ImageGalleryPreview> createState() => _ImageGalleryPreviewState();
}

class _ImageGalleryPreviewState extends State<ImageGalleryPreview> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  void _goToPrevious() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _goToNext() {
    if (_currentIndex < widget.images.length - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(12),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.85,
            color: Colors.black,
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: widget.images.length,
                  onPageChanged: (index) =>
                      setState(() => _currentIndex = index),
                  itemBuilder: (context, index) {
                    return Center(
                      child: Image.network(
                        widget.images[index],
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return const CircularProgressIndicator();
                        },
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, color: Colors.white),
                      ),
                    );
                  },
                ),
                // Left Arrow
                if (_currentIndex > 0)
                  Positioned(
                    left: 10,
                    top: MediaQuery.of(context).size.height * 0.35,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios,
                          color: Colors.white, size: 32),
                      onPressed: _goToPrevious,
                    ),
                  ),
                // Right Arrow
                if (_currentIndex < widget.images.length - 1)
                  Positioned(
                    right: 10,
                    top: MediaQuery.of(context).size.height * 0.35,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios,
                          color: Colors.white, size: 32),
                      onPressed: _goToNext,
                    ),
                  ),
                // Close Button
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                // Indicator
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      '${_currentIndex + 1} / ${widget.images.length}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class YouTubeHelper {
  static String? extractVideoId(String url) {
    // Handle various YouTube URL formats
    final regExp = RegExp(
        r'(?:youtube\.com\/(?:[^\/]+\/.+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([^"&?\/\s]{11})');
    final match = regExp.firstMatch(url);
    return match?.group(1);
  }

  static String getThumbnailUrl(String videoId) {
    return 'https://img.youtube.com/vi/$videoId/maxresdefault.jpg';
  }

  static bool isYouTubeUrl(String url) {
    return url.contains('youtube.com') || url.contains('youtu.be');
  }
}

// Updated PropertyCard1 class with YouTube support
class PropertyCard extends StatefulWidget {
  final Map<String, dynamic> property;
  final VoidCallback onPhonePressed;
  final VoidCallback onWhatsAppPressed;
  final VoidCallback onMapPressed;
  final bool isMobile;

  const PropertyCard(
      {super.key,
      required this.property,
      required this.onPhonePressed,
      required this.onWhatsAppPressed,
      required this.onMapPressed,
      required this.isMobile});

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _expandAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildCarouselItem(String url) {
    if (YouTubeHelper.isYouTubeUrl(url)) {
      final videoId = YouTubeHelper.extractVideoId(url);
      if (videoId != null) {
        return Stack(
          children: [
            Image.network(
              YouTubeHelper.getThumbnailUrl(videoId),
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Center(child: Icon(Icons.broken_image)),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(12),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 24,
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
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          const Center(child: Icon(Icons.broken_image)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Carousel for Images and Videos
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: SizedBox(
                height: 180,
                width: double.infinity,
                child: CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 1.0,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 4),
                    height: 180,
                  ),
                  items: (widget.property['images'] as List<String>)
                      .map((url) => _buildCarouselItem(url))
                      .toList(),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.property['title'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            widget.property['location'],
                            style: const TextStyle(
                                fontSize: 11, color: Colors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.property['forRent']
                          ? '₹${widget.property['rentAmount']}/month'
                          : '₹${(widget.property['price'] / 100000).toStringAsFixed(1)} Lakhs',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        _buildPropertyDetail(Icons.straighten,
                            '${widget.property['squareFeet']} sq.ft'),
                        if (widget.property['bedrooms'] > 0)
                          _buildPropertyDetail(
                              Icons.bed, '${widget.property['bedrooms']} BHK'),
                      ],
                    ),
                    AnimatedBuilder(
                      animation: _expandAnimation,
                      builder: (context, child) {
                        return ClipRect(
                          child: Align(
                            alignment: Alignment.topCenter,
                            heightFactor: _expandAnimation.value,
                            child: child,
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Divider(height: 16),
                          if (widget.property['builtupArea'] > 0)
                            _buildDetailRow('Built-up Area',
                                '${widget.property['builtupArea']} sq.ft'),
                          if (widget.property['grounds'] > 0)
                            _buildDetailRow(
                                'Grounds', '${widget.property['grounds']}'),
                          _buildDetailRow(
                              'Landmark', widget.property['landmark']),
                          if (widget.property['waterTax'] > 0)
                            _buildDetailRow('Water Tax',
                                '₹${widget.property['waterTax']} / year'),
                          if (widget.property['propertyTax'] > 0)
                            _buildDetailRow('Property Tax',
                                '₹${widget.property['propertyTax']} / year'),
                          if (widget.property['bathrooms'] > 0)
                            _buildDetailRow(
                                'Bathrooms', '${widget.property['bathrooms']}'),
                          if (widget.property['ageYears'] > 0)
                            _buildDetailRow('Building Age',
                                '${widget.property['ageYears']} years'),
                          _buildDetailRow('Type', widget.property['type']),
                          _buildDetailRow('City', widget.property['city']),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextButton(
                      onPressed: _toggleExpansion,
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _isExpanded
                                ? 'Show Less Details'
                                : 'Show More Details',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Icon(
                            _isExpanded ? Icons.expand_less : Icons.expand_more,
                            size: 16,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const Spacer(),
                          TextButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => MediaGalleryPreview(
                                  mediaUrls: List<String>.from(
                                      widget.property['images']),
                                ),
                              );
                            },
                            icon: const Icon(Icons.photo_library, size: 16),
                            label: const Text('View All Media'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                 
                    Row(
                      children: [
                        if (widget.property['mapLink'] != null &&
                            widget.property['mapLink']
                                .toString()
                                .trim()
                                .isNotEmpty)
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: widget.onMapPressed,
                              icon: const Icon(Icons.location_on, size: 14),
                              label: const Text('Map',
                                  style: TextStyle(fontSize: 11)),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.blue,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 10),
                                minimumSize: const Size(80, 36),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        if (widget.property['mapLink'] != null &&
                            widget.property['mapLink']
                                .toString()
                                .trim()
                                .isNotEmpty)
                          const SizedBox(width: 6),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: widget.onPhonePressed,
                            icon: const Icon(Icons.phone, size: 14),
                            label: const Text('Phone',
                                style: TextStyle(fontSize: 11)),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 10),
                              minimumSize: const Size(80, 36),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: widget.onWhatsAppPressed,
                            icon:
                                const Icon(FontAwesomeIcons.whatsapp, size: 14),
                            label: const Text('WhatsApp',
                                style: TextStyle(fontSize: 11)),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 10),
                              minimumSize: const Size(
                                  90, 36), // ensures space for long word
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyDetail(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: Colors.grey),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 11)),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 11),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class MediaGalleryPreview extends StatefulWidget {
  final List<String> mediaUrls;

  const MediaGalleryPreview({super.key, required this.mediaUrls});

  @override
  State<MediaGalleryPreview> createState() => _MediaGalleryPreviewState();
}

class _MediaGalleryPreviewState extends State<MediaGalleryPreview> {
  late PageController _pageController;
  int _currentIndex = 0;
  final Map<int, YoutubePlayerController> _youtubeControllers = {};

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in _youtubeControllers.values) {
      controller.close();
    }
    _pageController.dispose();
    super.dispose();
  }

  YoutubePlayerController _getYouTubeController(String videoId, int index) {
    if (_youtubeControllers[index] != null) {
      return _youtubeControllers[index]!;
    }

    final controller = YoutubePlayerController(
      initialVideoId: videoId,
      params: const YoutubePlayerParams(
        autoPlay: false,
        showControls: true,
        showFullscreenButton: false,
        enableCaption: true,
        privacyEnhanced: true,
      ),
    );

    _youtubeControllers[index] = controller;
    return controller;
  }

  void _goToPrevious() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNext() {
    if (_currentIndex < widget.mediaUrls.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _buildMediaItem(String url, int index) {
    if (YouTubeHelper.isYouTubeUrl(url)) {
      final videoId = YouTubeHelper.extractVideoId(url);
      if (videoId != null) {
        final controller = _getYouTubeController(videoId, index);
        return Center(
          child: Container(
            // Constrain the YouTube player to a reasonable size
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width *
                  0.85, // Leave space for nav buttons
              maxHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: YoutubePlayerIFrame(controller: controller),
              ),
            ),
          ),
        );
      }
    }

    // Regular image
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.85,
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        child: Image.network(
          url,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return const CircularProgressIndicator();
          },
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.broken_image, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(12),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.85,
        color: Colors.black,
        child: Stack(
          children: [
            // Main content area with padding to avoid nav buttons
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 60), // Space for nav buttons
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.mediaUrls.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildMediaItem(widget.mediaUrls[index], index);
                },
              ),
            ),

            // Previous button - positioned to be always accessible
            if (_currentIndex > 0)
              Positioned(
                left: 10,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios,
                          color: Colors.white, size: 32),
                      onPressed: _goToPrevious,
                    ),
                  ),
                ),
              ),

            // Next button - positioned to be always accessible
            if (_currentIndex < widget.mediaUrls.length - 1)
              Positioned(
                right: 10,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios,
                          color: Colors.white, size: 32),
                      onPressed: _goToNext,
                    ),
                  ),
                ),
              ),

            // Close button
            Positioned(
              top: 20,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),

            // Media type indicator
            Positioned(
              top: 20,
              left: 20,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      YouTubeHelper.isYouTubeUrl(
                              widget.mediaUrls[_currentIndex])
                          ? Icons.play_circle_outline
                          : Icons.image,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      YouTubeHelper.isYouTubeUrl(
                              widget.mediaUrls[_currentIndex])
                          ? 'Video'
                          : 'Image',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),

            // Page indicator
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '${_currentIndex + 1} / ${widget.mediaUrls.length}',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
