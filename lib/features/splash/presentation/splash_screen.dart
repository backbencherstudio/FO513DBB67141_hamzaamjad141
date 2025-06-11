import 'dart:math';
import 'package:aviation_app/core/constant/logos.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routes/route_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  final planeSize = 40.0;
  final animationDuration = Duration(milliseconds: 1600);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: animationDuration,
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastEaseInToSlowEaseOut,
    );

    _animationController.forward();

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        context.go(RouteName.onboardingScreen);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Offset _flightPath(double t, Size screenSize) {
    /// Custom arc: left to center with a dip and lift
    final startX = -planeSize;
    final endX = screenSize.width / 2 - planeSize / 2;
    final midY = screenSize.height / 2 - 60;

    final x = startX + (endX - startX) * t;
    final y =
        midY + 130 * sin(pi * t); // sine wave to arc it down then up again

    return Offset(x, y);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final position = _flightPath(_animation.value, screenSize);

        return CreateScreen(
          child: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // SizedBox(height: 40), // for plane space
                      // const SizedBox(height: 16),
                      Text(
                        'LEFT SEAT LESSONS',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: position.dx,
                top: position.dy,
                child: SizedBox(
                  width: planeSize,
                  height: planeSize,
                  child: SvgPicture.asset(
                    AppLogo.paperPlane,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
