import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/presentation/screens/auth_screen.dart';
import '../features/location/presentation/screens/location_picker_screen.dart';
import '../features/places/presentation/screens/explore_screen.dart';
import '../features/places/presentation/screens/place_detail_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import '../features/saved/presentation/screens/saved_screen.dart';
import '../features/splash/presentation/splash_screen.dart';
import '../features/welcome/presentation/welcome_screen.dart';
import 'widgets/bottom_nav_bar.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: BottomNavBar(navigationShell: navigationShell),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/explore',
              builder: (context, state) => const ExploreScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/saved',
              builder: (context, state) => const SavedScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/place/:id',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return PlaceDetailScreen(id: id);
      },
    ),
    GoRoute(
      path: '/map',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final from = state.uri.queryParameters['from'];
        return LocationPickerScreen(from: from);
      },
    ),
    GoRoute(
      path: '/sign-in',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const AuthScreen(mode: AuthMode.signIn),
    ),
    GoRoute(
      path: '/sign-up',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const AuthScreen(mode: AuthMode.signUp),
    ),
    GoRoute(
      path: '/forgot-password',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const AuthScreen(mode: AuthMode.reset),
    ),
  ],
);
