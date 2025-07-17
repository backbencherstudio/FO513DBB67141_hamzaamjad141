class PaymentState {
  final String? paymentId;
  final bool isLoading;
  PaymentState({this.paymentId, this.isLoading = false});
  PaymentState copyWith({String? paymentId, bool? isLoading}) {
    return PaymentState(
      paymentId: paymentId ?? this.paymentId,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  PaymentState clearPaymentId() {
    return PaymentState(paymentId: null, isLoading: false);
  }
}
