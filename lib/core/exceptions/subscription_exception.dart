class SubscriptionException implements Exception {
  final String message;
  final bool trialEnded;
  final String? trialEndDate;
  final String? upgradeUrl;

  const SubscriptionException({
    required this.message,
    required this.trialEnded,
    this.trialEndDate,
    this.upgradeUrl,
  });

  @override
  String toString() => 'SubscriptionException: $message';
}

