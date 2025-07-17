import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaybackState {
  final bool isSpeaking;
  final double progress;

  PlaybackState({required this.isSpeaking, required this.progress});

  PlaybackState copyWith({bool? isSpeaking, double? progress}) {
    return PlaybackState(
      isSpeaking: isSpeaking ?? this.isSpeaking,
      progress: progress ?? this.progress,
    );
  }
}

class PlaybackStateNotifier extends StateNotifier<Map<String, PlaybackState>> {
  PlaybackStateNotifier() : super({});

  void updateState(String id, {bool? isSpeaking, double? progress}) {
    final currentState = state[id] ?? PlaybackState(isSpeaking: false, progress: 0.0);
    state = {
      ...state,
      id: currentState.copyWith(
        isSpeaking: isSpeaking ?? currentState.isSpeaking,
        progress: progress ?? currentState.progress,
      ),
    };
    debugPrint('Updated state for id: $id, isSpeaking: ${state[id]?.isSpeaking}, progress: ${state[id]?.progress}');
  }

  void resetState(String id) {
    state = {
      ...state,
      id: PlaybackState(isSpeaking: false, progress: 0.0),
    };
    debugPrint('Reset state for id: $id');
  }
}

// Global provider for playback states
final playbackStateProvider = StateNotifierProvider<PlaybackStateNotifier, Map<String, PlaybackState>>((ref) {
  return PlaybackStateNotifier();
});