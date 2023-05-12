import 'package:bali_rent/views/ui/carlist_page/carlist_main.dart';
import 'package:bali_rent/views/ui/login_page/login_main.dart';
import 'package:bali_rent/views/ui/register_page/register_main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/homescreen_page/homescreen_main.dart';
import '../ui/welcome_page/welcome_main.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
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
            routes: <RouteBase>[
              GoRoute(
                name: 'carlist',
                path: 'carlist',
                builder: (BuildContext context, GoRouterState state) {
                  return const CarListMain();
                },
              ),
              GoRoute(
                  path: 'login',
                  builder: (BuildContext context, GoRouterState state) {
                    return const LoginMain();
                  },
                  routes: <RouteBase>[
                    GoRoute(
                      path: 'register',
                      builder: (BuildContext context, GoRouterState state) {
                        return const RegisterMain();
                      },
                    )
                  ]),
            ]),
      ],
    ),
  ],
);
