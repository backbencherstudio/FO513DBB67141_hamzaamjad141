import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../exceptions/subscription_exception.dart';
import '../../utils/utils.dart';
import '../navigation_service/navigation_service.dart';
import 'api_endpoints.dart';

class ApiServices {
  /// Singleton instance
  static final ApiServices instance = ApiServices._internal();
  ApiServices._internal();

  /// Helper method to handle the response
  static dynamic _handleResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 403) {
      // Handle 403 subscription errors
      try {
        final responseBody = jsonDecode(response.body);
        
        // Check if it's a subscription-related 403 error
        if (responseBody['message'] != null && 
            (responseBody['message'].toString().contains('Premium subscription required') ||
             responseBody['trialEnded'] == true)) {
          
          // Navigate to subscription page
          NavigationService.instance.navigateToSubscription();
          
          throw SubscriptionException(
            message: responseBody['message'] ?? 'Premium subscription required',
            trialEnded: responseBody['trialEnded'] ?? true,
            trialEndDate: responseBody['trialEndDate'],
            upgradeUrl: responseBody['upgradeUrl'],
          );
        }
      } catch (e) {
        if (e is SubscriptionException) {
          rethrow;
        }
        // If it's not a valid JSON or doesn't match subscription error format
        // fall through to generic error handling
      }
      
      throw Exception('Error: ${response.statusCode}, ${response.body}');
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
    var response;
    try {
      final isOnline = await Utils.isOnline();
      if (isOnline) {
         response = await http.post(
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
      if (e is SubscriptionException) {
        // Don't show toast for subscription errors as user is being redirected
        rethrow;
      }
      try {
        final decodedBody = jsonDecode(response.body);
        Utils.showErrorToast(message: decodedBody['message']);
      } catch (_) {
        // If response body is not valid JSON, show generic error
        Utils.showErrorToast(message: "An error occurred");
      }
      throw Exception("Failed to send data: $e");
    }
  }

  /// http get request service
  Future<dynamic> getData({
    required String endPoint,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiEndPoints.baseUrl}/$endPoint'),
        headers: headers,
      );
      return _handleResponse(response);
    } catch (e) {
      if (e is SubscriptionException) {
        rethrow;
      }
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
      if (e is SubscriptionException) {
        rethrow;
      }
      throw Exception("Failed to send data: $e");
    }
  }

  Future<dynamic> deleteData({
    required String endPoint,
    required Map<String, String> headers,
}) async {
    try {
      final response = await http.delete(
        Uri.parse('${ApiEndPoints.baseUrl}/$endPoint'),
        headers: headers,
      );
      return _handleResponse(response);
    } catch (e) {
      if (e is SubscriptionException) {
        rethrow;
      }
      throw Exception("Failed to send data: $e");
    }
  }
}
