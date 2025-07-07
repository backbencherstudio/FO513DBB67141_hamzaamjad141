import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aviation_app/core/services/api_services/api_endpoints.dart';

class AiChatRepository {
  /// Function to get the Gemini AI response from the server
  Future<String> getGeminiResponse(String message) async {
    try {
      final url = '${ApiEndPoints.baseUrl}/ai/generate/$message';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['success'] == true) {
          return data['data'] as String;
        } else {
          throw Exception(data['message'] ?? 'Unknown error occurred');
        }
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
