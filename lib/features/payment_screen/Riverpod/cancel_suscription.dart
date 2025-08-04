import 'dart:convert';
import 'package:aviation_app/core/services/api_services/api_endpoints.dart';
import 'package:aviation_app/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class CancelSubscription {
  static Future<void> cancel(String token) async {
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
        //Utils.showErrorToast(message: 'Successfully cancelled your subscription');
        Fluttertoast.showToast(
          msg: decoded['message'],
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } else {
        final msg = decoded['message'] ?? "Cancellation failed";
        Utils.showErrorToast(message: msg.toString());
      }
    } catch (e) {
      Utils.showErrorToast(message: "An error occurred: ${e.toString()}");
      throw Exception(e);
    }
  }
}
