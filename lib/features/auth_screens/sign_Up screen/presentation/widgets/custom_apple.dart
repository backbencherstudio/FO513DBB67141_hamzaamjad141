import 'package:aviation_app/features/auth_screens/auth_provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class AppleLoginButton extends StatelessWidget {
  final String text;
  final String img;
  const AppleLoginButton({super.key,
  required this.text,
  required this.img,

  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, _) {
        final authNotifier = ref.read(authProvider.notifier);
        return GestureDetector(
          onTap: () async {
            final routeName = await authNotifier.createAccountWithApple();
            if(context.mounted){
              context.go(routeName);
            }
          },
          child: Container(
             height: 56.h,
             width: 327.w,
             decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: Color(0xff100F1C)
             ),
             child: Padding(
               padding:  EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
               child: Row(
                children: [
                  SvgPicture.asset(img, color: const Color.fromARGB(255, 255, 255, 255),height: 22.h, width: 22.w,),
                  SizedBox(width:10.w),
                  Text(text,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Color(0xffF9FAFB),
                  ),
                  )
                ],
               ),
             ),
          ),
        );
      }
    );
  }
}