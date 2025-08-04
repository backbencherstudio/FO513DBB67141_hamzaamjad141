class PaymentState {
  final String? paymentId;
  final bool isLoading;
  final bool isWebPageButtonLoading;
  PaymentState({this.paymentId, this.isLoading = false,this.isWebPageButtonLoading = false});
  PaymentState copyWith({String? paymentId, bool? isLoading, bool? isWebPageButtonLoading}) {
    return PaymentState(
      paymentId: paymentId ?? this.paymentId,
      isLoading: isLoading ?? this.isLoading,
      isWebPageButtonLoading: isWebPageButtonLoading ?? this.isWebPageButtonLoading,
    );
  }

  PaymentState clearPaymentId() {
    return PaymentState(paymentId: null, isLoading: false, isWebPageButtonLoading : false);
  }
}
