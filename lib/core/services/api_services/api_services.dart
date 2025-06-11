import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../utils/utils.dart';
import 'api_endpoints.dart';

class ApiServices {
  /// Singleton instance
  static final ApiServices instance = ApiServices._internal();
  ApiServices._internal();

  /// Helper method to handle the response

  static dynamic _handleResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error: ${response.statusCode}, ${response.body}');
    }
  }

  /// http Post request service
  Future<dynamic> postData({
    required String endPoint,
    required Map<String, dynamic> body,
    required Map<String, String> headers,
  }) async {
    try {
      final isOnline = await Utils.isOnline();
      if (isOnline) {
        final response = await http.post(
          Uri.parse('${ApiEndPoints.baseUrl}/$endPoint'),
          headers: headers,
          body: jsonEncode(body),
        );
        return _handleResponse(response);
      } else {
        Utils.showErrorToast(
          message: "Device is Offline, Please connect to internet.",
        );
        throw Exception('Device is Offline, Please connect to internet.');
      }
    } catch (e) {
      Utils.showErrorToast(message: "Failed to send data.");
      throw Exception("Failed to send data: $e");
    }
  }

  /// http get request service
  Future<dynamic> getData({
    required String endPoint,
    required Map<String, String> headers,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiEndPoints.baseUrl}/$endPoint'),
        headers: headers,
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception("Failed to send data: $e");
    }
  }

  /// http Put request service
  Future<dynamic> putData({
    required String endPoint,
    required Map<String, dynamic> body,
    required Map<String, String> headers,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('${ApiEndPoints.baseUrl}/$endPoint'),
        headers: headers,
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception("Failed to send data: $e");
    }
  }
}
