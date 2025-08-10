import 'package:supabase_flutter/supabase_flutter.dart';

class PropertyService {
  final SupabaseClient _supabase = Supabase.instance.client;
  // Updated fetchProperties method with new default values
  Future<List<Map<String, dynamic>>> fetchProperties() async {
    try {
      final response = await _supabase
          .from('cpd')
          .select('id, property_data, created_at')
          .order('created_at', ascending: false);

      print('Raw response: $response');

      return response.map<Map<String, dynamic>>((item) {
        final propertyData = Map<String, dynamic>.from(item['property_data']);
        
        // Add the main id and created_at to the property data
        propertyData['main_id'] = item['id'];
        propertyData['created_at'] = item['created_at'];
        
        // Ensure all required fields exist with default values
        propertyData['city'] = propertyData['city'] ?? 'N/A';
        propertyData['type'] = propertyData['type'] ?? 'N/A';
        propertyData['price'] = propertyData['price'] ?? 0;
        propertyData['title'] = propertyData['title'] ?? 'No title';
        propertyData['images'] = propertyData['images'] ?? [];
        propertyData['forRent'] = propertyData['forRent'] ?? false;
        propertyData['grounds'] = propertyData['grounds'] ?? 0;
        propertyData['mapLink'] = propertyData['mapLink'] ?? '';
        propertyData['ageYears'] = propertyData['ageYears'] ?? 0;
        propertyData['bedrooms'] = propertyData['bedrooms'] ?? 0;
        propertyData['location'] = propertyData['location'] ?? 'No location';
        propertyData['waterTax'] = propertyData['waterTax'] ?? 0;
        propertyData['bathrooms'] = propertyData['bathrooms'] ?? 0;
        propertyData['rentAmount'] = propertyData['rentAmount'] ?? 0;
        propertyData['squareFeet'] = propertyData['squareFeet'] ?? 0;
        propertyData['builtupArea'] = propertyData['builtupArea'] ?? 0;
        propertyData['propertyTax'] = propertyData['propertyTax'] ?? 0;
        
        // NEW FIELDS WITH DEFAULT VALUES
        propertyData['purpose'] = propertyData['purpose'] ?? 'For Sale';
        propertyData['propertyStatus'] = propertyData['propertyStatus'] ?? 'New';
        propertyData['negotiablePrice'] = propertyData['negotiablePrice'] ?? false;
        propertyData['maintenanceCharges'] = propertyData['maintenanceCharges'] ?? 0;
        propertyData['depositAmount'] = propertyData['depositAmount'] ?? 0;
        propertyData['floorNumber'] = propertyData['floorNumber'] ?? 0;
        propertyData['totalFloors'] = propertyData['totalFloors'] ?? 0;
        propertyData['parkingAvailable'] = propertyData['parkingAvailable'] ?? false;
        propertyData['parkingCount'] = propertyData['parkingCount'] ?? 0;
        propertyData['balconyAvailable'] = propertyData['balconyAvailable'] ?? false;
        propertyData['balconyCount'] = propertyData['balconyCount'] ?? 0;
        propertyData['furnishingStatus'] = propertyData['furnishingStatus'] ?? 'Unfurnished';
        propertyData['ownerType'] = propertyData['ownerType'] ?? 'Owner';
        propertyData['contactPerson'] = propertyData['contactPerson'] ?? '';
        propertyData['description'] = propertyData['description'] ?? '';
        propertyData['urgentSale'] = propertyData['urgentSale'] ?? false;
        
        // Handle landmarks - some properties have 'landmark' (string) and some have 'landmarks' (array)
        if (propertyData['landmark'] != null && propertyData['landmarks'] == null) {
          propertyData['landmarks'] = [propertyData['landmark']];
        } else if (propertyData['landmarks'] == null) {
          propertyData['landmarks'] = [];
        }
        
        // Handle contact data - ensure consistent structure
        if (propertyData['contact'] == null) {
          propertyData['contact'] = {
            'phone': '',
            'whatsapp': '',
            'phoneNumbers': []
          };
        } else {
          final contact = propertyData['contact'];
          // Ensure phone field exists
          if (contact['phone'] == null && contact['phoneNumbers'] != null && contact['phoneNumbers'].isNotEmpty) {
            contact['phone'] = contact['phoneNumbers'][0];
          }
          // Ensure whatsapp field exists
          if (contact['whatsapp'] == null) {
            contact['whatsapp'] = contact['phone'] ?? '';
          }
        }
        print('Property data: $propertyData');
        return propertyData;
      }).toList();
    } catch (e) {
      print('Error fetching properties: $e');
      return [];
    }
  }

  Future<bool> addProperty(Map<String, dynamic> propertyData) async {
    try {
      final result = await _supabase.from('cpd').insert({
        'property_data': propertyData,
        'created_at': DateTime.now().toIso8601String(),
      }).select();

      print('Insert result: $result');
      return true;
    } catch (e) {
      print('Error adding property: $e');
      return false;
    }
  }

  // Update existing property
  Future<bool> updateProperty(int id, Map<String, dynamic> propertyData) async {
    try {
      await _supabase
          .from('cpd')
          .update({'property_data': propertyData})
          .eq('id', id);
      return true;
    } catch (e) {
      print('Error updating property: $e');
      return false;
    }
  }

  // Delete property
  Future<bool> deleteProperty(int id) async {
    try {
      await _supabase.from('cpd').delete().eq('id', id);
      return true;
    } catch (e) {
      print('Error deleting property: $e');
      return false;
    }
  }

  // Helper method to delete image from storage when property is deleted
  Future<bool> deleteImage(String imageUrl) async {
    try {
      // Extract file path from URL
      final uri = Uri.parse(imageUrl);
      final pathSegments = uri.pathSegments;
      final fileName = pathSegments.last;
      final filePath = 'property_images/$fileName';
      
      await _supabase.storage
          .from('property-images')
          .remove([filePath]);
      
      return true;
    } catch (e) {
      print('Error deleting image: $e');
      return false;
    }
  }
}