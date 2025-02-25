import 'package:cat_ai_gen/data/data.dart';
import 'package:cat_ai_gen/routing/routing.dart';
import 'package:cat_ai_gen/ui/app_view.dart';
import 'package:cat_ai_gen/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final _routerKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final _shellNavigatorNotificationsKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellNotifications');
final _shellNavigatorSettingsKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellSettings');

GoRouter router(AuthRepository authRepository) {
  return GoRouter(
    navigatorKey: _routerKey,
    initialLocation: Routes.auth,
    debugLogDiagnostics: true,
    redirect: _redirect,
    refreshListenable: authRepository,
    routes: [
      GoRoute(
        path: Routes.auth,
        builder: (context, state) {
          return SignInScreen(
            viewModel: SignInViewModel(
              authRepository: context.read(),
            ),
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppView(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHomeKey,
            routes: [
              GoRoute(
                path: Routes.home,
                builder: (context, state) {
                  return HomeScreen();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorNotificationsKey,
            routes: [
              GoRoute(
                path: Routes.notifications,
                builder: (context, state) {
                  return NotificationsScreen();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorSettingsKey,
            routes: [
              GoRoute(
                path: Routes.settings,
                builder: (context, state) {
                  return SettingsScreen();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  // If the user is not signed in, they need to sign in
  final signedIn = context.read<AuthRepository>().isAuthenticated;
  final signingIn = state.matchedLocation == Routes.auth;

  if (!signedIn) {
    return Routes.auth;
  }

  // if the user is logged in but still on the login page, send them to
  // the home page
  if (signingIn) {
    return Routes.home;
  }

  // no need to redirect at all
  return null;
}
