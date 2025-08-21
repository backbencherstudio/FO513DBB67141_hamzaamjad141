import 'dart:convert';
import 'package:aviation_app/core/services/api_services/api_endpoints.dart';
import 'package:aviation_app/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class CancelSubscription {
  static Future<Map<String, dynamic>?> cancel(String token) async {
    try {
      debugPrint(token);
      debugPrint(ApiEndPoints.cancelSubscription);
      final headers = {
        'Authorization': token,
        'Content-Type': 'application/json',
      };

      var response = await http.post(
        Uri.parse('${ApiEndPoints.baseUrl}/${ApiEndPoints.cancelSubscription}'),
        headers: headers,
      );

      debugPrint("Raw response body: ${response.body}");

      /// Decode JSON
      final decoded = jsonDecode(response.body);

      /// Check success
      if (decoded['success'] == true) {
        final accessUntil = decoded['accessUntil'];
        final message = decoded['message'] ?? 'Subscription cancelled successfully';
        
        // Show success message with access information
        String displayMessage = message;
        if (accessUntil != null) {
          final accessDate = DateTime.parse(accessUntil);
          final formattedDate = "${accessDate.day}/${accessDate.month}/${accessDate.year}";
          displayMessage += "\nYou'll retain access until $formattedDate";
        }
        
        Fluttertoast.showToast(
          msg: displayMessage,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
        );
        
        return {
          'success': true,
          'message': message,
          'accessUntil': accessUntil,
        };
      } else {
        final msg = decoded['message'] ?? "Cancellation failed";
        Utils.showErrorToast(message: msg.toString());
        return {
          'success': false,
          'message': msg,
        };
      }
    } catch (e) {
      Utils.showErrorToast(message: "An error occurred: ${e.toString()}");
      return {
        'success': false,
        'message': "An error occurred: ${e.toString()}",
      };
    }
  }
}
