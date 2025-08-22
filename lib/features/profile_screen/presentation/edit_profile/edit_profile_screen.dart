// ignore_for_file: unnecessary_null_comparison

import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/core/routes/route_name.dart';
import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:aviation_app/core/utils/utils.dart';
import 'package:aviation_app/features/auth_screens/auth_provider/auth_provider.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:aviation_app/features/profile_screen/presentation/edit_profile/widget/deleteBottomSheet.dart';
import 'package:aviation_app/features/profile_screen/presentation/widgets/profile_screen_header.dart';
import 'package:aviation_app/features/profile_screen/riverpod/deleteAccountProvider.dart';
import 'package:aviation_app/features/profile_screen/riverpod/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import 'widget/custom_text_field.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late final TextEditingController fullNameEditingController;
  late final TextEditingController emailEditingController;

  @override
  void initState() {
    fullNameEditingController = TextEditingController();
    emailEditingController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = ref.watch(authProvider).user;
      fullNameEditingController.text = user?.name ?? "";
      emailEditingController.text = user?.email ?? "";
    });
    super.initState();
  }

  @override
  void dispose() {
    fullNameEditingController.dispose();
    emailEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return CreateScreen(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileScreenHeader(),
              Padding(
                padding: AppPadding.screenHorizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Profile Settings', style: textTheme.bodyLarge),
                    SizedBox(height: 16.h),
                    Container(
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 12.h,
                        children: [
                          // Align(
                          //   alignment: Alignment.centerRight,
                          //   child: SvgPicture.asset(
                          //     AppIcons.editProfile,
                          //   ),
                          // ),
                          CustomTextField(
                            controller: fullNameEditingController,
                            textTheme: textTheme,
                            labelName: 'Full Name',
                            hintText: 'Enter your full name',
                          ),
                          CustomTextField(
                            controller: emailEditingController,
                            enabled: false,
                            textTheme: textTheme,
                            labelName: 'Email',
                            hintText: 'Enter your email',
                          ),

                          // CustomTextField(
                          //   textTheme: textTheme,
                          //   labelName: 'Old Password',
                          //   hintText: 'Enter old password',
                          // ),
                          // CustomTextField(
                          //   textTheme: textTheme,
                          //   labelName: 'New Password',
                          //   hintText: 'Enter your new password',
                          // ),
                          // CustomTextField(
                          //   textTheme: textTheme,
                          //   labelName: 'Confirm Password',
                          //   hintText: 'Enter your new password',
                          // ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),
                    Consumer(
                      builder: (_, ref, _) {
                        return Utils.primaryButton(
                          onPressed: () async {
                            await ref
                                .read(profileProvider.notifier)
                                .onSubmit(name: fullNameEditingController.text);
                            context.pop();
                          },
                          text: 'Save Change',
                        );
                      },
                    ),
                    SizedBox(height: 18.h),

               
                        
                        
                        
                            Utils.primaryButton(
                                onPressed: ()  {
                                  

confirmDeleteBottomSheet(
  context: context,
  onDelete: (){}
);


                                  
                                },
                                backgroundColor: AppColors.surface,
                                text: 'Delete my account',
                     
                    ),

                    SizedBox(height: 40.h),
                    
                  ],
                ),
              ),
              SizedBox(height: 145.h),
            ],
          ),
        ),
      ),
    );
  }
}
