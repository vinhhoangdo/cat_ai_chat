import 'package:cat_ai_gen/data/data.dart';
import 'package:cat_ai_gen/routing/routing.dart';
import 'package:cat_ai_gen/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

GoRouter router(AuthRepository authRepository) {
  return GoRouter(
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
      GoRoute(
        path: Routes.home,
        builder: (context, state) {
          return HomeScreen();
        },
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
