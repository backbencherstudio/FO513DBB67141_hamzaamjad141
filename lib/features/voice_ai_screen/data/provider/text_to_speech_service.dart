import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aviation_app/features/voice_ai_screen/data/provider/playback_state.dart';
import 'dart:async';

// Provider for TextToSpeechService
final textToSpeechServiceProvider = Provider<TextToSpeechService>((ref) => TextToSpeechService(ref));

class TextToSpeechService {
  final Ref ref;
  FlutterTts flutterTts = FlutterTts();
  Timer? _progressTimer;
  String? _currentMessageId;

  TextToSpeechService(this.ref);

  // Clean text by removing special characters and Markdown
  String _cleanText(String text) {
    // Remove Markdown symbols (*, **, #, etc.), newlines, and excessive whitespace
    String cleaned = text
        .replaceAll(RegExp(r'\*+\s*'), '') // Remove * and ** with optional spaces
        .replaceAll(RegExp(r'#+\s*'), '') // Remove #, ##, etc.
        .replaceAll(RegExp(r'[-_]+'), ' ') // Replace - and _ with space
        .replaceAll(RegExp(r'\n+'), ' ') // Replace newlines with space
        .replaceAll(RegExp(r'\s+'), ' ') // Collapse multiple spaces
        .trim();
    debugPrint('Original text: "${text.substring(0, text.length > 50 ? 50 : text.length)}..."');
    debugPrint('Cleaned text for TTS: "${cleaned.substring(0, cleaned.length > 50 ? 50 : cleaned.length)}..."');
    return cleaned;
  }

  Future<void> speakText(String text, String messageId) async {
    try {
      // Stop any ongoing playback
      await flutterTts.stop();
      _progressTimer?.cancel();
      if (_currentMessageId != null) {
        ref.read(playbackStateProvider.notifier).resetState(_currentMessageId!);
      }
      debugPrint('Stopped any existing playback');

      // Clean text for TTS
      final cleanedText = _cleanText(text);
      if (cleanedText.trim().isEmpty) {
        debugPrint('Cleaned text is empty for id: $messageId, skipping playback');
        ref.read(playbackStateProvider.notifier).resetState(messageId);
        return;
      }

      // Check TTS engine availability
      final engines = await flutterTts.getEngines;
      debugPrint('Available TTS engines: $engines');
      if (engines.isEmpty) {
        debugPrint('No TTS engines available for id: $messageId');
        ref.read(playbackStateProvider.notifier).resetState(messageId);
        throw Exception('No TTS engines available');
      }

      // Check language availability
      final isLanguageAvailable = await flutterTts.isLanguageAvailable("en-US");
      debugPrint('TTS language en-US available: $isLanguageAvailable');
      if (!isLanguageAvailable) {
        throw Exception('TTS language en-US not available');
      }

      // Configure TTS
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.setVolume(1.0);
      await flutterTts.setPitch(1.0);
      try {
        await flutterTts.setVoice({"name": "en-us-x-sfg#male_1-local", "locale": "en-US"});
      } catch (e) {
        debugPrint('Error setting TTS voice for id: $messageId: $e');
        await flutterTts.setVoice({"name": "en-US-language", "locale": "en-US"});
      }

      // List available voices for debugging
      final voices = await flutterTts.getVoices;
      debugPrint('Available voices: $voices');

      // Split cleaned text into chunks (max 4000 characters)
      const maxChunkLength = 4000;
      List<String> chunks = [];
      for (int i = 0; i < cleanedText.length; i += maxChunkLength) {
        chunks.add(cleanedText.substring(i, i + maxChunkLength < cleanedText.length ? i + maxChunkLength : cleanedText.length));
      }
      debugPrint('Text split into ${chunks.length} chunks for id: $messageId');

      // Estimate duration based on cleaned text
      final wordCount = cleanedText.split(RegExp(r'\s+')).length;
      const wordsPerMinute = 70; // Adjusted for speech rate 0.5
      final estimatedDuration = (wordCount / wordsPerMinute) * 60.0;
      final safeDuration = estimatedDuration < 0.1 ? 0.1 : estimatedDuration;

      // Set completion and error handlers
      flutterTts.setCompletionHandler(() {
        debugPrint('TTS playback completed for id: $messageId');
        _progressTimer?.cancel();
        ref.read(playbackStateProvider.notifier).updateState(messageId, isSpeaking: false, progress: 1.0);
        _currentMessageId = null;
      });

      flutterTts.setErrorHandler((msg) {
        debugPrint('TTS error for id: $messageId: $msg');
        _progressTimer?.cancel();
        ref.read(playbackStateProvider.notifier).resetState(messageId);
        _currentMessageId = null;
      });

      // Start playback
      debugPrint('Starting TTS playback for id: $messageId, Estimated duration: $safeDuration seconds');
      _currentMessageId = messageId;
      ref.read(playbackStateProvider.notifier).updateState(messageId, isSpeaking: true, progress: 0.0);

      // Simulate progress with a timer
      double progress = 0.0;
      const updateInterval = Duration(milliseconds: 100);
      final steps = (safeDuration * 1000) ~/ updateInterval.inMilliseconds;
      debugPrint('Starting progress timer for id: $messageId with $steps steps');
      _progressTimer = Timer.periodic(updateInterval, (timer) {
        progress += 1 / steps;
        if (progress >= 1.0) {
          progress = 1.0;
          timer.cancel();
          debugPrint('Progress timer completed for id: $messageId: $progress');
        }
        debugPrint('Progress update for id: $messageId: $progress');
        ref.read(playbackStateProvider.notifier).updateState(messageId, progress: progress);
      });

      // Play chunks sequentially
      for (int i = 0; i < chunks.length; i++) {
        debugPrint('Playing chunk ${i + 1}/${chunks.length} for id: $messageId: "${chunks[i].substring(0, chunks[i].length > 50 ? 50 : chunks[i].length)}..."');
        final result = await flutterTts.speak(chunks[i]);
        debugPrint('TTS speak result for chunk ${i + 1}, id: $messageId: $result');
        if (result != 1) {
          debugPrint('TTS speak failed for chunk ${i + 1}, id: $messageId');
          throw Exception('TTS speak failed for chunk ${i + 1}');
        }
      }
    } catch (e) {
      debugPrint('Error in TTS playback for id: $messageId: $e');
      _progressTimer?.cancel();
      ref.read(playbackStateProvider.notifier).resetState(messageId);
      _currentMessageId = null;
      throw Exception('TTS playback failed: $e');
    }
  }

  void stop() {
    flutterTts.stop();
    _progressTimer?.cancel();
    if (_currentMessageId != null) {
      ref.read(playbackStateProvider.notifier).resetState(_currentMessageId!);
      debugPrint('TTS playback stopped for id: $_currentMessageId');
      _currentMessageId = null;
    }
  }

  void dispose() {
    _progressTimer?.cancel();
    flutterTts.stop();
    if (_currentMessageId != null) {
      ref.read(playbackStateProvider.notifier).resetState(_currentMessageId!);
      _currentMessageId = null;
    }
    debugPrint('TextToSpeechService disposed');
  }
}