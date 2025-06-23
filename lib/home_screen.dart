import 'package:animate_do/animate_do.dart';
import 'package:checkdreamproperty/widgets/contact.dart';
import 'package:checkdreamproperty/appbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';

import 'add_property_dialog.dart';
import 'models/property_model.dart';
import 'property_card.dart';

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
  RangeValues _priceRange = const RangeValues(100000, 100000000);
  final PropertyService _propertyService = PropertyService();
  bool _isLoading = false;
  final List<Map<String, dynamic>> _properties = [];
  bool isMobile = false;

  @override
  void initState() {
    super.initState();
    _loadProperties();
  }

  List<String> _locations = ['All Locations']; // Initialize with default value

  // Future<void> _loadProperties() async {
  //   setState(() => _isLoading = true);
  //   try {
  //     final properties = await _propertyService.fetchProperties();
  //     // Extract unique locations from properties
  //     final uniqueLocations = properties
  //         .map((p) => p['city']?.toString() ?? '')
  //         .where((loc) => loc.isNotEmpty)
  //         .toSet()
  //         .toList();

  //     setState(() {
  //       _properties.clear();
  //       _properties.addAll(properties);
  //       _locations = ['All Locations', ...uniqueLocations];
  //     });
  //   } catch (e) {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Error loading properties: $e')),
  //       );
  //     }
  //   } finally {
  //     setState(() => _isLoading = false);
  //   }
  // }




  Future<void> _addProperty(Map<String, dynamic> propertyData) async {
    setState(() => _isLoading = true);
    try {
      final success = await _propertyService.addProperty(propertyData);
      if (success) {
        await _loadProperties(); // Refresh the list
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Property added successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        throw Exception('Failed to add property');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding property: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  final List<String> _propertyTypes = [
    'All Properties',
    'Apartment',
    'Villa',
    'Plot',
    'Commercial'
  ];

  // List<Map<String, dynamic>> get filteredProperties {
  //   return _properties.where((property) {
  //     final matchesType = _selectedPropertyType == 'All Properties' ||
  //         property['type'] == _selectedPropertyType;
  //     final matchesLocation = _selectedLocation == 'All Locations' ||
  //         property['city'] == _selectedLocation;
  //     final price =
  //         property['forRent'] ? property['rentAmount'] : property['price'];
  //     final matchesPrice =
  //         price >= _priceRange.start && price <= _priceRange.end;

  //     return matchesType && matchesLocation && matchesPrice;
  //   }).toList();
  // }

  Future<void> _loadProperties() async {
  setState(() => _isLoading = true);
  try {
    final properties = await _propertyService.fetchProperties();
    print('Total properties fetched: ${properties.length}');
    
    // Debug: Print each property title and key data
    for (int i = 0; i < properties.length; i++) {
      final prop = properties[i];
      print('Property $i: ${prop['title']} - City: ${prop['city']} - Type: ${prop['type']}');
    }
    
    // Extract unique locations from properties
    final uniqueLocations = properties
        .map((p) => p['city']?.toString() ?? '')
        .where((loc) => loc.isNotEmpty && loc != 'N/A')
        .toSet()
        .toList();

    print('Unique locations found: $uniqueLocations');

    setState(() {
      _properties.clear();
      _properties.addAll(properties);
      _locations = ['All Locations', ...uniqueLocations];
      print('Properties in state: ${_properties.length}');
      print('Locations in state: $_locations');
    });
  } catch (e) {
    print('Error loading properties: $e');
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading properties: $e')),
      );
    }
  } finally {
    setState(() => _isLoading = false);
  }
}

// Also update your filteredProperties getter with better debugging
List<Map<String, dynamic>> get filteredProperties {
  final filtered = _properties.where((property) {
    final matchesType = _selectedPropertyType == 'All Properties' ||
        property['type'] == _selectedPropertyType;
    final matchesLocation = _selectedLocation == 'All Locations' ||
        property['city'] == _selectedLocation;
    final price =
        property['forRent'] == true ? (property['rentAmount'] ?? 0) : (property['price'] ?? 0);
    final matchesPrice =
        price >= _priceRange.start && price <= _priceRange.end;

    // Debug logging
    if (!matchesType) {
      print('Property ${property['title']} filtered out by type: ${property['type']} != $_selectedPropertyType');
    }
    if (!matchesLocation) {
      print('Property ${property['title']} filtered out by location: ${property['city']} != $_selectedLocation');
    }
    if (!matchesPrice) {
      print('Property ${property['title']} filtered out by price: $price not in range ${_priceRange.start}-${_priceRange.end}');
    }

    return matchesType && matchesLocation && matchesPrice;
  }).toList();
  
  print('Filtered properties count: ${filtered.length} out of ${_properties.length}');
  return filtered;
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
          _buildSearchSection(),
          _buildFeaturedProperties(),
          const SizedBox(
            height: 20,
          ),
          const ContactUsPage()
        ],
      ),
    );
  }

  String _formatPrice(double value) {
    if (value >= 10000000) {
      return '₹${(value / 10000000).toStringAsFixed(2)} Cr';
    } else {
      return '₹${(value / 100000).toStringAsFixed(1)} L';
    }
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
            style: GoogleFonts.poppins(
              fontSize: 18,
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
          const SizedBox(height: 10),

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Budget Range',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),

                    /// Price tags (below label)
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildPriceTag(
                              context, _formatPrice(_priceRange.start)),
                          _buildPriceTag(
                              context, _formatPrice(_priceRange.end)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    /// Range Slider
                    SliderTheme(
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
                        min: 100000, // ₹1 Lakh
                        max: 200000000, // ₹20 Crore
                        divisions: 100,
                        labels: RangeLabels(
                          _formatPrice(_priceRange.start),
                          _formatPrice(_priceRange.end),
                        ),
                        onChanged: (values) {
                          setState(() => _priceRange = values);
                        },
                      ),
                    ),
                  ],
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
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget _buildSearchField({required Widget child}) {
    return child;
  }

  void _showAddPropertyDialog() {
    showDialog(
      context: context,
      builder: (context) => AddPropertyDialog(
        onPropertyAdded: _addProperty,
        properties: _properties,
      ),
    );
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
  Widget _buildFeaturedProperties() {
    if (_isLoading && _properties.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (filteredProperties.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: [
              const Icon(Icons.search_off, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              Text(
                _properties.isEmpty
                    ? 'No properties available'
                    : 'No properties found matching your criteria',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade700,
                ),
                textAlign: TextAlign.center,
              ),
              if (_properties.isEmpty)
                TextButton(
                  onPressed: _loadProperties,
                  child: const Text('Retry'),
                ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: FadeInLeft(
                  child: Text(
                    'Featured Properties',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 18,
                      color: const Color(0xFF333333),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (_isLoading && _properties.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

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
                mainAxisSpacing: 8,
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
    isMobile = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      appBar: buildResponsiveAppBar(context, _selectedIndex, (index) {
        setState(() {
          _selectedIndex = index;
        });
      }),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: _loadProperties,
              child: _buildBody(),
            ),
      floatingActionButton: isMobile
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              onPressed: _showAddPropertyDialog,
              tooltip: 'Add Property',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
