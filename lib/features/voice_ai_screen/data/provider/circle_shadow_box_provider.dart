// lib/core/state/circle_hold_controller.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CircleHoldController extends StateNotifier<bool> {
  CircleHoldController() : super(false);

  void hold(bool value) => state = value;
}

final circleHoldProvider =
StateNotifierProvider<CircleHoldController, bool>((ref) {
  return CircleHoldController();
});
