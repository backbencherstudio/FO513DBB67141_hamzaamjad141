import 'package:aviation_app/features/payment_screen/Riverpod/cancel_suscription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth_screens/auth_provider/auth_provider.dart';
class SubscriptionCancelDialog extends StatelessWidget {
  const SubscriptionCancelDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Cancel Subscription"),
      content: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          style: const TextStyle(color: Colors.white, fontSize: 16),
          children: [
            TextSpan(
              text: "Subscription will be canceled at the end of the billing period.\n\n",
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
            TextSpan(
              text: "Are you sure you want to cancel your subscription?",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.red, // optional emphasis
              ),
            ),
          ],
        ),
      ),
        actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
        Consumer(
          builder: (context, ref, _) {
            final userToken = ref.watch(authProvider).userToken;
            if (userToken == null) {
              debugPrint("User token is null");
            }
            return TextButton(
              onPressed: () async {
                try {
                  final result = await CancelSubscription.cancel(userToken!);
                  Navigator.of(context).pop();
                  
                  // If cancellation was successful, refresh user data to reflect current status
                  if (result?['success'] == true) {
                    await ref.read(authProvider.notifier).updateUserModel();
                  }
                } catch (e) {
                  Navigator.of(context).pop();
                  debugPrint("Error cancelling subscription: $e");
                }
              },
              child: Text("Yes"),
            );
          }
        ),
      ],
    );
  }
}
