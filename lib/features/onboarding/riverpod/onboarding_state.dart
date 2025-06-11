class OnboardingState{

  int currentOnboardingIndex;

  OnboardingState({this.currentOnboardingIndex = 0});

  OnboardingState copyWith({int? currentOnboardingIndex}){
    return OnboardingState(
      currentOnboardingIndex: currentOnboardingIndex ?? this.currentOnboardingIndex
    );
  }
}