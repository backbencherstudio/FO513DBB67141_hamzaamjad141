import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../theme/theme_extension/app_colors.dart';

class Utils {
  static Widget customAppBar({
    String? leadingImageAddress,
    String? title,
    String? subtitle,
    String? subtitlePreIconAsset,
    List<Widget>? trailing,
    Border? appBarBgColor,
    required BuildContext context,
    bool? isBackButton,
  }) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Container(
        height: 64.h,
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: AppColors.onPrimary,
          borderRadius: BorderRadius.circular(16.r),
          border: appBarBgColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 33,
              color: const Color(0xff000000).withOpacity(0.1),
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Leading: custom widget or image
            leadingImageAddress != null
                ? Container(
                    height: 44.w,
                    width: 44.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.2),
                      image: DecorationImage(
                        image: AssetImage(leadingImageAddress),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : SizedBox(),

            SizedBox(width: 12.w),

            // Title and subtitle section
            if (title != null || subtitle != null)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null)
                      Expanded(
                        child: Text(
                          title,
                          style: textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w700,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                    if (subtitle != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (subtitlePreIconAsset != null)
                            Padding(
                              padding: EdgeInsets.only(right: 4.w),
                              child: SvgPicture.asset(
                                subtitlePreIconAsset,
                                height: 16.h,
                                width: 16.w,
                                colorFilter: ColorFilter.mode(
                                  AppColors.onSurface,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          Text(
                            subtitle,
                            style: textTheme.bodyMedium!.copyWith(
                              color: AppColors.onSurface,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),

            // Trailing actions
            if (trailing != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: trailing,
              ),
          ],
        ),
      ),
    );
  }

  static Widget primaryButton({
    required VoidCallback? onPressed,
    required String text,
    Color? backgroundColor,
    TextStyle? textStyle,
    double? height,
    double? width,
    BorderRadius? borderRadius,
    bool isLoading = false
  }) {
    return SizedBox(
      height: height,
      width: width ?? double.infinity,
      child: isLoading ? Center(child: const CircularProgressIndicator()) : ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 12.h),
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12.r),
          ),
        ),
        onPressed: onPressed,
        child: Text(text, style: textStyle),
      ),
    );
  }

  static Widget secondaryButton({
    required VoidCallback onPressed,
    required String imageAsset,
    EdgeInsets? padding,
    String? buttonName,
    Color? backgroundColor,
    TextStyle? buttonNameTextStyle,
    double? height,
    double? width,
    BorderRadius? borderRadius,
    required BuildContext context,
    Color? iconColor,
  }) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            //  height: height ??72.w,
            //  width: width??74.w,
            padding:
                padding ??
                EdgeInsets.symmetric(horizontal: 16.2.w, vertical: 17.1.h),
            decoration: BoxDecoration(
              borderRadius: borderRadius ?? BorderRadius.circular(12.r),
              color: backgroundColor ?? colorScheme.surface.withOpacity(0.08),
            ),
            child: SvgPicture.asset(
              imageAsset,
              colorFilter: ColorFilter.mode(
                iconColor ?? colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        if (buttonName != null) ...[
          SizedBox(height: 12.h),
          Text(buttonName, style: buttonNameTextStyle ?? textTheme.bodySmall),
        ],
      ],
    );
  }

  static String weekdayToString(int weekday) {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return days[weekday - 1];
  }

  static String monthToString(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  static Future<bool> isOnline() async {
    try {
      final result = await Connectivity().checkConnectivity();
      if (result.contains(ConnectivityResult.wifi) ||
          result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.ethernet)) {
        return true;
      } else {
        return false;
      }
    } on PlatformException catch (e) {
      throw Exception('Couldn\'t check connectivity status: $e');
    }
  }

  static void alertOfflineActivity() {
    Fluttertoast.showToast(
      msg: "Please connect to internet",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  static String dateFormat({required DateTime date, String? format}) {
    return DateFormat(format ?? 'dd MMM, yyyy').format(date);
  }

  static Widget networkImage({
    required String imageUrl,
    double? width,
    double? height,
  }) {
    return Image.network(
      // 'https://car-wash-backend.signalsmind.com/public/storage/avatar/e8f6578776d1f9352ae5d1baab11faccimage2.webp',
      imageUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child; // Image is fully loaded
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Icon(
          Icons.image_not_supported,
          size: 35.sp,
        ); // Show an error icons if the image fails to load
      },
    );
  }

  static Future<bool?> showErrorToast({required String message}) {
    return Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }
}
