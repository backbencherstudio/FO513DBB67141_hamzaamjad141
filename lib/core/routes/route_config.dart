import 'package:aviation_app/core/routes/build_page_with_transition.dart';
import 'package:aviation_app/core/routes/route_name.dart';
import 'package:aviation_app/features/ebook_screen/ebook_screen.dart';
import 'package:aviation_app/features/pilot_log_book/pilot_log_book_screen.dart';
import 'package:aviation_app/features/podcast_screen/podcast_screen.dart';
import 'package:aviation_app/features/voice_ai_screen/voice_ai_screen.dart';
import 'package:aviation_app/features/weather_screen/weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../utils/common_widget/nav_bar/bottom_navbar.dart';

class RouteConfig {
  GoRouter goRouter = GoRouter(
    initialLocation: RouteName.ebookScreen,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            BottomBarWidget(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteName.weatherScreen,
                builder: (context, state) => const WeatherScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteName.pilotLogBookScreen,
                builder: (context, state) => const PilotLogBookScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteName.voiceAIScreen,
                builder: (context, state) => const VoiceAiScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteName.podcastScreen,
                builder: (context, state) => const PodcastScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteName.ebookScreen,
                builder: (context, state) => const EbookScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        name: RouteName.splashScreen,
        path: RouteName.splashScreen,
        pageBuilder: (context, state) {
          return const MaterialPage(child: SplashScreen());
        },
      ),

      GoRoute(
        name: RouteName.onboardingScreen,
        path: RouteName.onboardingScreen,
        pageBuilder: (context, state) {
          return buildPageWithTransition(
            context: context,
            state: state,
            transitionType: PageTransitionType.fade,
            child: OnboardingScreen(),
          );
        },
      ),
      /*GoRoute(
        name: RouteName.onboardingScreen,
        path: RouteName.onboardingScreen,
        pageBuilder: (context, state) {
          return buildPageWithTransition(
            context: context,
            state: state,
            transitionType: PageTransitionType.fade,
            child: OnboardingScreen(),
          );
        },
      ),*/

      /*GoRoute(
        name: RouteName.ebookScreen,
        path: RouteName.ebookScreen,
        pageBuilder: (context, state) {
          return buildPageWithTransition(
            context: context,
            state: state,
            transitionType: PageTransitionType.fade,
            child: EbookScreen(),
          );
        },
      ),*/
    ],
  );
}
