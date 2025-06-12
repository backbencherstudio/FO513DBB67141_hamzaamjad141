import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constant/icons.dart';
import '../../../theme/theme_extension/app_colors.dart';
import 'bottom_nav_state.dart';

class BottomBarWidget extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const BottomBarWidget({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          final bottomNavState = ref.watch(bottomNavProvider);

          return bottomNavState.isBottomSheetOpen
              ? const SizedBox.shrink()
              : Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(left: 24.w, bottom: 8.h),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.r),
                    child: SizedBox(
                      height: 65.h,
                      child: BottomNavigationBar(
                        currentIndex: navigationShell.currentIndex,
                        onTap: (index) => navigationShell.goBranch(index),
                        type: BottomNavigationBarType.fixed,
                        backgroundColor: AppColors.bottomNavBarBackground,
                        elevation: 5,
                        selectedLabelStyle: TextStyle(fontSize: 0),
                        unselectedLabelStyle: TextStyle(fontSize: 0),
                        items: [
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                              navigationShell.currentIndex == 0
                                  ? AppIcons.weatherOutline
                                  : AppIcons.weatherFill,
                            ),
                            label: "",
                          ),
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                              navigationShell.currentIndex == 1
                                  ? AppIcons.pilotLogBookOutline
                                  : AppIcons.pilotLogBookFill,
                            ),
                            label: "",
                          ),
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                              navigationShell.currentIndex == 2
                                  ? AppIcons.voiceAiSvg
                                  : AppIcons.voiceAiSvg,
                            ),
                            label: "",
                          ),
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                              navigationShell.currentIndex == 3
                                  ? AppIcons.podcastOutline
                                  : AppIcons.podcastFill,
                            ),
                            label: "",
                          ),
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                              navigationShell.currentIndex == 4
                                  ? AppIcons.eBookOutline
                                  : AppIcons.eBookFill,
                            ),
                            label: "",
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
