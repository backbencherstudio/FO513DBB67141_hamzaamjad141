import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:aviation_app/core/utils/common_widget/common_widget.dart';
import 'package:aviation_app/core/utils/common_widget/primary_button/primary_button.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../riverpod/log_book_notifier.dart';
import '../log_entry_screen/widgets/flight_log_custom_text_form_field.dart';

class InstructorEntryScreen extends StatefulWidget {
  const InstructorEntryScreen({super.key});

  @override
  State<InstructorEntryScreen> createState() => _InstructorEntryScreenState();
}

class _InstructorEntryScreenState extends State<InstructorEntryScreen> {
  late final TextEditingController emailController;
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final FocusNode emailFocusNode;
  late final FocusNode nameFocusNode;
  late final FocusNode phoneFocusNode;

  @override
  void initState() {
    emailController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailFocusNode = FocusNode();
    nameFocusNode = FocusNode();
    phoneFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    nameFocusNode.dispose();
    phoneFocusNode.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CreateScreen(
      child: Padding(
        padding: AppPadding.screenHorizontal,
        child: SafeArea(
          child: ListView(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: CommonWidget.secondaryButton(
                  child: Icon(Icons.arrow_back),
                  onTap: () => context.pop(),
                ),
              ),
              SizedBox(height: 18.h),
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.25),
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppColors.secondary,
                ),
                child: Column(
                  spacing: 16.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Set Default Instructor",
                      style: textTheme.titleMedium,
                    ),
                    FlightLogCustomTextField(
                      label: "Email",
                      hint: "Enter instructor email",
                      controller: emailController,
                      focusNode: emailFocusNode,
                    ),
                    FlightLogCustomTextField(
                      label: "Name",
                      hint: "Enter instructor Name",
                      controller: nameController,
                      focusNode: nameFocusNode,
                    ),
                    FlightLogCustomTextField(
                      label: "Phone",
                      hint: "Enter instructor phone",
                      controller: phoneController,
                      focusNode: phoneFocusNode,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18.h),
              Consumer(
                builder: (_, ref, _) {
                  final isLoading = ref
                      .watch(logBookProvider)
                      .instructorButtonLoading;
                  return isLoading
                      ? Center(child: CircularProgressIndicator())
                      : PrimaryButton(
                          bodyText: "Save Instructor",
                          onTap: () async {
                            if (emailController.text.isNotEmpty) {
                              final success = await ref
                                  .read(logBookProvider.notifier)
                                  .setDefaultInstructor(
                                name: nameController.text,
                                    email: emailController.text,
                                phone: phoneController.text
                                  );
                              if (success == true && context.mounted) {
                                context.pop();
                              }
                            }
                          },
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
