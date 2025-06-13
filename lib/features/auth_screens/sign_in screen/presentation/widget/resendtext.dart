import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Resendtext extends StatelessWidget {
  const Resendtext({super.key});

  @override
  Widget build(BuildContext context) {
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
            debugPrint("\n\n\n\n\n tappeeeddddddddd \n\n\n\n");
           
            },
          ),
        ],
      ),
    );
  }
}
