import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker_app/core/constants/app_constants.dart';
import 'package:mood_tracker_app/presentation/pages/home_page.dart';
import 'package:mood_tracker_app/presentation/pages/login_page.dart';
import 'package:mood_tracker_app/presentation/pages/mood_page.dart';
import 'package:mood_tracker_app/presentation/pages/analytics_page.dart';
import 'package:mood_tracker_app/presentation/pages/settings_page.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppConstants.homeRoute,
    routes: [
      GoRoute(
        path: AppConstants.homeRoute,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppConstants.loginRoute,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppConstants.moodRoute,
        name: 'mood',
        builder: (context, state) => const MoodPage(),
      ),
      GoRoute(
        path: AppConstants.analyticsRoute,
        name: 'analytics',
        builder: (context, state) => const AnalyticsPage(),
      ),
      GoRoute(
        path: AppConstants.settingsRoute,
        name: 'settings',
        builder: (context, state) => const SettingsPage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.matchedLocation}'),
      ),
    ),
  );
}
