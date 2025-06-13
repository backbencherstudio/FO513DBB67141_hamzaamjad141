import 'package:aviation_app/core/constant/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomforgetmeSection extends StatelessWidget {
  const CustomforgetmeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return Padding(
      padding: AppPadding.screenHorizontal,
      child: Row(
        children: [
          Checkbox(value: true, onChanged: (v) {}),
          SizedBox(width: 1.w),
          Text("Remember me",
          style: style.bodyMedium!.copyWith( fontWeight: FontWeight.w400,color: Color(0xffffffff))
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              
            },
            child: Text("Forget Password?",
             style: style.bodyMedium!.copyWith( fontWeight: FontWeight.w400,color: Color(0xffffffff))
            ),
          ),
        ],
      ),
    );
  }
}

