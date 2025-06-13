import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:aviation_app/core/utils/common_widget/primary_button/primary_button.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:aviation_app/features/ebook_screen/presentation/widgets/e_book_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CreateScreen(
      child: Padding(
        padding: AppPadding.screenHorizontal,
        child: SingleChildScrollView(
          child: Column(
            children: [
              EBookAppBar(textTheme: textTheme),
              SizedBox(height: 55.h),
              Text("Aviation Weather", style: textTheme.headlineMedium),
              SizedBox(height: 24.h),
              Container(
                width: 327.w,
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 13.h,
                        horizontal: 19.w,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "ICAO Code",
                              style: textTheme.bodyMedium?.copyWith(
                                color: AppColors.secondaryTextColor,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: TextFormField(

                              focusNode: _focusNode,
                              onTapOutside: (_) => _focusNode.unfocus(),
                              decoration: InputDecoration(
                                hintText: "Enter ICAO code",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h,),

                    SizedBox(
                        width: double.infinity,
                        child: PrimaryButton(bodyText: "Get Weather",))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
