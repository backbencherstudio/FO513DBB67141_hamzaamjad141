import 'package:aviation_app/core/routes/route_name.dart';
import 'package:aviation_app/core/utils/utils.dart';
import 'package:aviation_app/features/auth_screens/auth_provider/auth_provider.dart';
import 'package:aviation_app/features/payment_screen/Riverpod/cancel_suscription.dart';
import 'package:aviation_app/features/profile_screen/riverpod/deleteAccountProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class confirmDeleteDialog extends StatelessWidget {
  const confirmDeleteDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Account Deletation"),
      content: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          style: const TextStyle(color: Colors.white, fontSize: 16),
          children: [
           
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
Utils.primaryButton(onPressed: () {
  Navigator.pop(context);
},
text: "No"
),
SizedBox(height: 15.h,),
Consumer(
  builder: (context, ref, _) {
    final callOut = ref.watch(deleteProvider);
    return callOut.isLoading == true
        ? Center(child: CircularProgressIndicator())
        : Utils.primaryButton(
            onPressed: () async {
              final path =
                  await ref.read(deleteProvider.notifier).deleteUser();

              if (path == "ok" && context.mounted) {
                debugPrint("✅ Routing to SignIn");
                context.go(RouteName.signInScreen);
                Fluttertoast.showToast(
                  msg: "Successfully deleted the account",
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                );
              } else {
                Fluttertoast.showToast(
                  msg: "Sorry, network issue!",
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                );
              }
            },
            text: "Yes", // Keep button label here
          );
  },
),
      ],
    );
  }
}
