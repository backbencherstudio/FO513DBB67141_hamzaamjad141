import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entity/chat_message_state.dart';
import '../../repository/ai_chat_repository.dart';



/// StateNotifier to handle API call
class VoiceAiNotifier extends StateNotifier<VoiceAiState> {
  final AiChatRepository _aiChatRepository;

  VoiceAiNotifier(this._aiChatRepository) : super(VoiceAiState());

  Future<void> getGeminiResponse(String message) async {
    try {
      /// Set loading to true and clear any previous error
      state = state.copyWith(isLoading: true, error: '');
      /// Add user message to the chat history
      final updatedMessages = [
        ...state.messages,
        ChatMessage(text: message, isUser: true, timestamp: DateTime.now()),
      ];
      state = state.copyWith(messages: updatedMessages);

      /// Call the repository function to get the AI response
      final aiResponse = await _aiChatRepository.getGeminiResponse(message);

      /// Add AI response to the chat history
      final newMessages = [
        ...state.messages,
        ChatMessage(text: aiResponse, isUser: false, timestamp: DateTime.now()),
      ];
      state = state.copyWith(messages: newMessages, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to connect to the server: $e',
        isLoading: false,
      );
    }
  }
}

/// Riverpod provider
final voiceAiProvider = StateNotifierProvider<VoiceAiNotifier, VoiceAiState>((ref) {
  return VoiceAiNotifier(AiChatRepository());
});
