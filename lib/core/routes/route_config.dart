part of 'part_of_import.dart';

class RouteConfig {
  GoRouter goRouter = GoRouter(
    initialLocation: RouteName.ebookScreen,

    routes: [
      /// Bottom NavBar
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
        name: RouteName.signupScreen,
        path: RouteName.signupScreen,
        pageBuilder: (context, state) {
          return const MaterialPage(child: SignupScreen());
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
    ],
  );
}
