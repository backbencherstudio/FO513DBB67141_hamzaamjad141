class trailState{
  final String? isSuccess;
  final String? message;
  final bool? hasRealSubscription;
  final bool? isloading ;
  trailState({
    this.isSuccess,
    this.message,
    this.hasRealSubscription,
    this.isloading,
  });
  trailState copyWith({
    String? isSuccess,
    String? message,
    bool? hasRealSubscription,
    bool? isloading,
  }) {
    return trailState(
      isSuccess: isSuccess ?? this.isSuccess,
      message: message ?? this.message,
      hasRealSubscription: hasRealSubscription ?? this.hasRealSubscription,
      isloading: isloading ?? this.isloading,
    );
  }
}