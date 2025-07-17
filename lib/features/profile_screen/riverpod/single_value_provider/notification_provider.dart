import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationProvider extends StateNotifier<bool> {
  NotificationProvider() : super(true); // Default is obfuscated

  /// Toggle the visibility of the password
  void toggleNotification(bool value) {
    state = value;
  }
}

final notificationProvider =
StateNotifierProvider<NotificationProvider, bool>((ref) {
  return NotificationProvider();
});