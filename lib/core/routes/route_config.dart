

part of 'part_of_import.dart';




class RouteConfig {
  GoRouter goRouter = GoRouter(

    initialLocation: RouteName.signInScreen,

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
        name: RouteName.signUpOtpScreen,
        path: RouteName.signUpOtpScreen,
        pageBuilder: (context, state) {
          return const MaterialPage(child: SignUpOtpScreen());
        },
      ),
 GoRoute(
        name: RouteName.signInScreen,
        path: RouteName.signInScreen,
        pageBuilder: (context, state) {
          return const MaterialPage(child: SignInScreen());
        },
      ),
       GoRoute(
        name: RouteName.acountCreatedScreen,
        path: RouteName.acountCreatedScreen,
        pageBuilder: (context, state) {
          return const MaterialPage(child: AcountCreatedScreen());
        },
      ),
          GoRoute(
        name: RouteName.forgetPasScreen,
        path: RouteName.forgetPasScreen,
        pageBuilder: (context, state) {
          return const MaterialPage(child: ForgetPasScreen());
        },
      ),
       GoRoute(
        name: RouteName.successScreen,
        path: RouteName.successScreen,
        pageBuilder: (context, state) {
          return const MaterialPage(child: SuccessScreen());
        },
      ),
       GoRoute(
        name: RouteName.forgetOtpScreen,
        path: RouteName.forgetOtpScreen,
        pageBuilder: (context, state) {
          return const MaterialPage(child: ForgetOtpScreen());
        },
      ),
       GoRoute(
        name: RouteName.resetPassScreen,
        path: RouteName.resetPassScreen,
        pageBuilder: (context, state) {
          return const MaterialPage(child: ResetPassScreen());
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
