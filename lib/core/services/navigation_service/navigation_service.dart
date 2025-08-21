import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  NavigationService._internal();
  
  static NavigationService get instance => _instance;
  
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  BuildContext? get context => navigatorKey.currentContext;
  
  /// Navigate to subscription page when premium subscription is required
  void navigateToSubscription() {
    if (context != null) {
      context!.push('/PaymentIntroScreen');
    }
  }
  
  /// Navigate to a specific route
  void navigateTo(String route) {
    if (context != null) {
      context!.push(route);
    }
  }
  
  /// Navigate and replace current route
  void navigateAndReplace(String route) {
    if (context != null) {
      context!.pushReplacement(route);
    }
  }
  
  /// Go back to previous screen
  void goBack() {
    if (context != null && context!.canPop()) {
      context!.pop();
    }
  }
}

