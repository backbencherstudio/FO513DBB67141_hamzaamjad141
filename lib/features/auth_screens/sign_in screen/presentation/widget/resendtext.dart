import 'package:aviation_app/features/auth_screens/auth_provider/auth_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Resendtext extends ConsumerWidget {
  final String email;
  const Resendtext({super.key, required this.email});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authProvider.notifier);
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Didn’t you receive any code? ",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
          ),
          TextSpan(
            text: "Resend Code",
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: Color(0xff3762E4),  decoration: TextDecoration.underline,  decorationColor: Color(0xff3762E4),
              decorationThickness: 2, ),
         recognizer: TapGestureRecognizer()..onTap = () {
           authNotifier.resendOtp(email: email);
           // debugPrint("\n\n\n\n\n tappeeeddddddddd \n\n\n\n");
           
            },
          ),
        ],
      ),
    );
  }
}
