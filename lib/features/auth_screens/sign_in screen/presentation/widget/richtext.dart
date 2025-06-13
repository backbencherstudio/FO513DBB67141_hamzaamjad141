import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignInOrSignUp extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const SignInOrSignUp({super.key,
  required this.text,
  required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Don’t have an account? ",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
          ),
          TextSpan(
            text: text,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: Color(0xff3762E4),  decoration: TextDecoration.underline,  decorationColor: Color(0xff3762E4),
              decorationThickness: 2, ),
         recognizer: TapGestureRecognizer()..onTap = onTap,
           
           
            
          ),
        ],
      ),
    );
  }
}
