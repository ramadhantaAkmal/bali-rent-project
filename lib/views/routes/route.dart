import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/homescreen_page/homescreen_main.dart';
import '../ui/welcome_page/welcome_main.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const WelcomeMain();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'homescreen',
          builder: (BuildContext context, GoRouterState state) {
            return const HomescreenMain();
          },
        ),
      ],
    ),
  ],
);
