/// Message class to represent user and AI messages
class ChatMessage {
  final String id;
  final String text;
  final bool isUser;
  final bool isAudio;
  final DateTime timestamp;

  ChatMessage({
    String? id,
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.isAudio = false,
  }) : id = id ?? timestamp.millisecondsSinceEpoch.toString(); // Use timestamp as ID if none provided
}

/// State class to hold the chat messages and loading status
class VoiceAiState {
  final List<ChatMessage> messages;
  final bool isLoading;
  final bool isAudio;
  final String error;

  VoiceAiState({
    this.messages = const [],
    this.isLoading = false,
    this.isAudio = false,
    this.error = '',
  });

  VoiceAiState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    bool? isAudio,
    String? error,
  }) {
    return VoiceAiState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      isAudio: isAudio ?? this.isAudio,
      error: error ?? this.error,
    );
  }
}