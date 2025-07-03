// lib/core/state/circle_hold_controller.dart

import 'package:aviation_app/features/voice_ai_screen/data/provider/voice_recorder_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CircleHoldController extends StateNotifier<bool> {
  final Ref ref;

  CircleHoldController(this.ref) : super(false);

  // Access recorder state using ref.watch
  void hold(bool value) {
    state = value;

    final recorderState = ref.read(recorderProvider.notifier);

    // Start or stop recording based on the value
    if (value) {
      recorderState.startRecording();
    } else {
      recorderState.stopRecording();
    }
  }
}

final circleHoldProvider = StateNotifierProvider<CircleHoldController, bool>((ref) {
  return CircleHoldController(ref);  // Passing ref to the controller
});
