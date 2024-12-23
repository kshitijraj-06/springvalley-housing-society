import 'dart:convert';
import 'package:http/http.dart' as http;

class FirestoreService {
  final String backendUrl = 'http://10.0.2.2:3000/getUserData';


  // Function to fetch user data based on user id (uid)
  Future<Map<String, dynamic>?> fetchUserData(int id) async {
    try {
      final response = await http.get(Uri.parse('$backendUrl/$id'));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      throw Exception('Error fetching user data: $e');
    }
  }
}
