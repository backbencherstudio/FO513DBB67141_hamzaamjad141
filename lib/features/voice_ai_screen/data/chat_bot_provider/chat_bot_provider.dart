import 'dart:convert';
import 'package:aviation_app/core/services/api_services/api_endpoints.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

// Message class to represent user and AI messages
class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp; // Added for accurate timestamps

  ChatMessage({required this.text, required this.isUser, required this.timestamp});
}

// State class to hold the chat messages and loading status
class VoiceAiState {
  final List<ChatMessage> messages;
  final bool isLoading;
  final String error;

  VoiceAiState({
    this.messages = const [],
    this.isLoading = false,
    this.error = '',
  });

  VoiceAiState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    String? error,
  }) {
    return VoiceAiState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

// StateNotifier to handle API call
class VoiceAiNotifier extends StateNotifier<VoiceAiState> {
  VoiceAiNotifier() : super(VoiceAiState());

  Future<void> getGeminiResponse(String message) async {
    try {
      // Set loading to true and clear any previous error
      state = state.copyWith(isLoading: true, error: '');
      // Add user message to the chat history
      final updatedMessages = [
        ...state.messages,
        ChatMessage(text: message, isUser: true, timestamp: DateTime.now()),
      ];
      state = state.copyWith(messages: updatedMessages);

      final url =
          '${ApiEndPoints.baseUrl}/ai/generate/$message';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['success'] == true) {
          // Extract the AI response from the 'data' field
          final aiResponse = data['data'] as String;
          // Add AI response to the chat history
          final newMessages = [
            ...state.messages,
            ChatMessage(
                text: aiResponse, isUser: false, timestamp: DateTime.now()),
          ];
          state = state.copyWith(messages: newMessages, isLoading: false);
        } else {
          state = state.copyWith(
            error: data['message'] ?? 'Unknown error occurred',
            isLoading: false,
          );
        }
      } else {
        state = state.copyWith(
          error: 'Error: ${response.statusCode}',
          isLoading: false,
        );
      }
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to connect to the server: $e',
        isLoading: false,
      );
    }
  }
}

// Riverpod provider
final voiceAiProvider =
StateNotifierProvider<VoiceAiNotifier, VoiceAiState>((ref) {
  return VoiceAiNotifier();
});