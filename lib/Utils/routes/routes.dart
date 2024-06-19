import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prepstar/View/Auth/login_page.dart';
import 'package:prepstar/View/CoursePage/Questions/questions.dart';
import 'package:prepstar/View/CoursePage/course_page.dart';
import 'package:prepstar/View/HomePage/home_page.dart';
import 'package:prepstar/View/Practice/practice.dart';
import 'package:prepstar/View/Profile/profile.dart';
import 'package:prepstar/View/SplashScreen/splash_screen.dart';
import 'package:prepstar/View/Wrapper/wrapper.dart';

class AppNavigation {
  AppNavigation._();

  static String initial = "/";

  // Private navigators
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHome =
      GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final _shellNavigatorSettings =
      GlobalKey<NavigatorState>(debugLabel: 'shellSettings');
  static final _shellNavigatorPractice =
      GlobalKey<NavigatorState>(debugLabel: 'shellPractice');

  // GoRouter configuration
  static final GoRouter router = GoRouter(
    initialLocation: initial,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      ///SplashScreen
      GoRoute(
        path: '/',
        name: 'Splash',
        builder: (context, state) => const SplashScreen(),
      ),

      /// LoginPage
      GoRoute(
        path: "/login",
        name: "Login",
        builder: (BuildContext context, GoRouterState state) =>
            const LoginScreen(),
      ),

      /// MainWrapper
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainWrapper(
            navigationShell: navigationShell,
          );
        },
        branches: <StatefulShellBranch>[
          /// Branch Home
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHome,
            routes: <RouteBase>[
              GoRoute(
                path: "/home",
                name: "Home",
                builder: (BuildContext context, GoRouterState state) =>
                    const HomePage(),
                routes: [
                  GoRoute(
                      path: 'course/:courseId',
                      name: 'CoursePage',
                      builder: (context, state) {
                        final courseId = state.pathParameters['courseId'];
                        return CoursePage(courseId: courseId!);
                      },
                      routes: [
                        GoRoute(
                          path: 'question',
                          name: 'Questions',
                          builder: (context, state) {
                            List data = state.extra as List;
                            return Questions(questions: data);
                          },
                        )
                      ]),
                ],
              ),
            ],
          ),

          /// Branch Practice
          StatefulShellBranch(
            navigatorKey: _shellNavigatorPractice,
            routes: <RouteBase>[
              GoRoute(
                path: "/practice",
                name: "Practice",
                builder: (BuildContext context, GoRouterState state) =>
                    const Practice(),
                routes: const [],
              ),
            ],
          ),

          /// Branch Setting
          StatefulShellBranch(
            navigatorKey: _shellNavigatorSettings,
            routes: <RouteBase>[
              GoRoute(
                path: "/proflie",
                name: "Profile",
                builder: (BuildContext context, GoRouterState state) =>
                    const Settings(),
                routes: const [],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
