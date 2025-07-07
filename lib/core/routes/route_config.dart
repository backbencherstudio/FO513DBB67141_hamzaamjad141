part of 'part_of_import.dart';

class RouteConfig {
  GoRouter goRouter = GoRouter(
    initialLocation: RouteName.splashScreen,

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
                pageBuilder: (context, state) {
                  return buildPageWithTransition(
                    context: context,
                    state: state,
                    transitionType: PageTransitionType.slideRightToLeft,
                    child: WeatherScreen(),
                  );
                },
                //builder: (context, state) => const WeatherScreen(),
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
        path: '${RouteName.signUpOtpScreen}/:email',
        pageBuilder: (context, state) {
          final email = state.pathParameters['email']!;
          return buildPageWithTransition(
            context: context,
            state: state,
            transitionType: PageTransitionType.fade,
            child: SignUpOtpScreen(email: email),
          );
        },
      ),
      GoRoute(
        name: RouteName.paymentSelection,
        path: RouteName.paymentSelection,
        pageBuilder: (context, state) {
          return const MaterialPage(child: PaymentSelection());
        },
      ),
      GoRoute(
        name: RouteName.paymentIntro,
        path: RouteName.paymentIntro,
        pageBuilder: (context, state) {
          return const MaterialPage(child: PaymentIntroScreen());
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
        name: RouteName.signupIntroScreen,
        path: RouteName.signupIntroScreen,
        pageBuilder: (context, state) {
          return const MaterialPage(child: SignupIntroScreen());
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
        path: '${RouteName.forgetOtpScreen}/:email',
        pageBuilder: (context, state) {
          final email = state.pathParameters['email']!;
          return buildPageWithTransition(
            context: context,
            state: state,
            transitionType: PageTransitionType.fade,
            child: ForgetOtpScreen(email: email),
          );
        },
      ),

      GoRoute(
        name: RouteName.resetPassScreen,
        path: '${RouteName.resetPassScreen}/:email',
        pageBuilder: (context, state) {
          final email = state.pathParameters['email']!;
          return buildPageWithTransition(
            context: context,
            state: state,
            transitionType: PageTransitionType.fade,
            child: ResetPassScreen(email: email),
          );
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
      GoRoute(
        name: RouteName.ebookPlay,
        path: '${RouteName.ebookPlay}/:ebookId',
        pageBuilder: (context, state) {
          final ebookId = state.pathParameters['ebookId']!;
          return buildPageWithTransition(
            context: context,
            state: state,
            transitionType: PageTransitionType.fade,
            child: EbookPlay(ebookId: ebookId),
          );
        },
      ),
      GoRoute(
        name: RouteName.aiAssistant,
        path: RouteName.aiAssistant,
        pageBuilder: (context, state) {
          return buildPageWithTransition(
            context: context,
            state: state,
            transitionType: PageTransitionType.fade,
            child: VoiceAiScreen(),
          );
        },
      ),
      GoRoute(
        name: RouteName.podcastPlayerScreen,
        path: '${RouteName.podcastPlayerScreen}/:podcastId',
        pageBuilder: (context, state) {
          final podcastId = state.pathParameters['podcastId']!;
          return buildPageWithTransition(
            context: context,
            state: state,
            transitionType: PageTransitionType.fade,
            child: PodcastPlayerScreen(podcastId: podcastId),
          );
        },
      ),

      GoRoute(
        name: RouteName.profileScreen,
        path: RouteName.profileScreen,
        pageBuilder: (context, state) {
          return buildPageWithTransition(
            context: context,
            state: state,
            transitionType: PageTransitionType.slideRightToLeft,
            child: ProfileScreen(),
          );
        },
      ),

      GoRoute(
        name: RouteName.logEntryScreen,
        path: RouteName.logEntryScreen,
        pageBuilder: (context, state) {
          return buildPageWithTransition(
            context: context,
            state: state,
            transitionType: PageTransitionType.slideRightToLeft,
            child: LogEntryScreen(),
          );
        },
      ),

      GoRoute(
        name: RouteName.instructorEntryScreen,
        path: RouteName.instructorEntryScreen,
        pageBuilder: (context, state) {
          return buildPageWithTransition(
            context: context,
            state: state,
            transitionType: PageTransitionType.slideRightToLeft,
            child: InstructorEntryScreen(),
          );
        },
      ),

      GoRoute(
        name: RouteName.editProfileScreen,
        path: RouteName.editProfileScreen,
        pageBuilder: (context, state) {
          return buildPageWithTransition(
            context: context,
            state: state,
            transitionType: PageTransitionType.slideRightToLeft,
            child: EditProfileScreen(),
          );
        },
      ),

      GoRoute(
        name: RouteName.dummyScreen,
        path: RouteName.dummyScreen,
        pageBuilder: (context, state) {
          return buildPageWithTransition(
            context: context,
            state: state,
            transitionType: PageTransitionType.slideRightToLeft,
            child: Dummy(),
          );
        },
      ),
    ],
  );
}
