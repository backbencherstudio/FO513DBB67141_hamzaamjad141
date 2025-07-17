import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/core/routes/route_name.dart';
import 'package:aviation_app/core/utils/common_widget/common_widget.dart';
import 'package:aviation_app/core/utils/common_widget/primary_button/primary_button.dart';
import 'package:aviation_app/features/auth_screens/auth_provider/auth_provider.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:aviation_app/features/profile_screen/presentation/widgets/log_out_bottom_sheet.dart';
import 'package:aviation_app/features/profile_screen/presentation/widgets/profile_screen_body.dart';
import 'package:aviation_app/features/profile_screen/presentation/widgets/profile_screen_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CreateScreen(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ProfileScreenHeader(),
          SizedBox(height: 34.h),
          ProfileScreenBody(),
        //  SizedBox(height: 10.h,),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(24.r),
              child: Consumer(
                builder: (_, ref, _) {
                  return PrimaryButton(
                    bodyText: "Log out",
                    onTap: () async {
                      await logOutBottomSheet(
                          context: context,
                        onLogOut: () async {
                           final success =   await ref.read(authProvider.notifier).signOut();
                          if(success == true && context.mounted){
                            context.go(RouteName.signInScreen);
                          }
                          }
                      );
                    },
                  );
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
