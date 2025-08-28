import 'package:aviation_app/core/routes/route_name.dart';
import 'package:aviation_app/features/profile_screen/riverpod/deleteAccountProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

Future<void> confirmDeleteBottomSheet({
  required BuildContext context,
  required Function onDelete,
}) async {
  await showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Color(0xff070707),
    context: context,
    builder: (_) {
      final textTheme = Theme.of(context).textTheme;
      return Container(
        width: 375,
        height: 390,
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 20,
          bottom: 32,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff2D3D99).withOpacity(0.25),
              Color(0xff070707),
            ],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close, size: 30),
              ),
            ),
            Text(
              "Are you sure you want\nto delete your account?",
              style: textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              "This action cannot be undone. All your data will be permanently deleted.",
              style: textTheme.bodyMedium,
              textAlign: TextAlign.center,
              textScaler: TextScaler.noScaling,
            ),
            Spacer(),
            Consumer(
              builder: (context, ref, _) {
                final deleteState = ref.watch(deleteProvider);
                return deleteState.isLoading == true
                    ? Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () async {
                          final path = await ref
                              .read(deleteProvider.notifier)
                              .deleteUser();

                          if (path == "ok" && context.mounted) {
                            Navigator.pop(context); // Close bottom sheet
                            debugPrint("Routing to SignIn");
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, // Red for delete action
                          foregroundColor: Colors.white,
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Text('Yes, Delete My Account'),
                      );
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800],
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Cancel'),
            ),
          ],
        ),
      );
    },
  );
}