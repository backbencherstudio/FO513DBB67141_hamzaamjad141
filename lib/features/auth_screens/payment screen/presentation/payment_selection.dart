import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/core/routes/route_name.dart';
import 'package:aviation_app/core/utils/common_widget/common_widget.dart';
import 'package:aviation_app/core/utils/utils.dart';
import 'package:aviation_app/features/auth_screens/payment%20screen/presentation/widgets/custom_select_tile.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class PaymentSelection extends StatelessWidget {
  const PaymentSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return CreateScreen(
      child: Padding(
        padding: AppPadding.screenHorizontal,
        child: Column(
        children: [
          SizedBox(height: 55.h,),
          Align(
          alignment: Alignment.centerLeft,
          child: CommonWidget.secondaryButton(child: SvgPicture.asset(AppIcons.backIcon) ,onTap: (){ Navigator.pop(context);})),
          SizedBox(height: 50.h,),
          Text("Choose Payment\n option",
          textAlign: TextAlign.center,
          style: style.headlineSmall!.copyWith(
          fontWeight: FontWeight.w500,
          color: Color(0xffffffff))),
          SizedBox(height: 24.h,),
          CustomSelectTile(title: 'Debit or Credit Card', discription: 'Securely use your Visa, MasterCard, or other major credit cards for your subscription.',
          img: AppIcons.card, isChecked: true, onTap: () {},),
          // SizedBox(height: 18.h,),
          // CustomSelectTile(title: 'Apple Pay', discription: 'Conveniently use Apple Pay for a quick and secure payment experience.',
          // img: AppIcons.appleStore, isChecked: true, onTap: () {},),
          SizedBox(height: 18.h,),
          CustomSelectTile(title: 'Google Pay', discription: 'Skip the form-filling. Pay faster using your Google account with one secure tap.',
          img: AppIcons.googleStore, isChecked: true, onTap: () {},),
          SizedBox(height: 72.h,),
          Utils.primaryButton(
          height: 54.h,
          onPressed: (){
          context.go(RouteName.weatherScreen);
          }, text: "Continue")
        ]),
    ));
  }
}
