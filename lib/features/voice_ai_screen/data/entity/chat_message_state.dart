import 'dart:core';

/// Message class to represent user and AI messages
class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({required this.text, required this.isUser, required this.timestamp});
}

/// State class to hold the chat messages and loading status
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
