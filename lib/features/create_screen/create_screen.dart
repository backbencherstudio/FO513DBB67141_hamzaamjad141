import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constant/images.dart';

class CreateScreen extends StatelessWidget{
  const CreateScreen({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              AppImages.screenBackgroundSvg,
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: child,
          ),

        ],
      ),
    );
  }
}