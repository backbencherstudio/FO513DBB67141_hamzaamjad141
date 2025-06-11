import 'package:aviation_app/features/onboarding/riverpod/onboarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final onboardingProvider = StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) => OnboardingNotifier());

class OnboardingNotifier extends StateNotifier<OnboardingState>{
  OnboardingNotifier() : super(OnboardingState());

  void onSlideToNextOnboarding(int index){
    debugPrint("\nonboarding index : $index\n");
    state = state.copyWith(
      currentOnboardingIndex: index
    );
  }

}