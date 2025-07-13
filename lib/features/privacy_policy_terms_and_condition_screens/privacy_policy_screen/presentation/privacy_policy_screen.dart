import 'dart:convert';

import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/common_widget/common_widget.dart';
import '../../data/data.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CreateScreen(
      child: SafeArea(
        child: Padding(
          padding: AppPadding.screenHorizontal,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              /// Back button
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 20.w,
                children: [
                  CommonWidget.secondaryButton(
                    onTap: () => context.pop(),
                    child: Icon(Icons.arrow_back),
                  ),
                  Text("Privacy Policy",style: textTheme.headlineSmall,)
                ],
              ),
              // SizedBox(height: 5.h,),
              // Align(
              //     alignment: Alignment.topLeft,
              //     child
              //     : Text("Privacy Policy",style: textTheme.headlineSmall,)),
              SizedBox(height: 20.h,),
              Text(
                (privacyPolicy) ,
                style: textTheme.bodySmall,
              ),


            ],
          ),
        ),
      ),
    );
  }
}
