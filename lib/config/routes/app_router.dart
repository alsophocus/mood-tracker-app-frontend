import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker_app/core/constants/app_constants.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppConstants.homeRoute,
    routes: [
      GoRoute(
        path: AppConstants.homeRoute,
        name: 'home',
        builder: (context, state) => const Placeholder(), // TODO: Replace with HomePage
      ),
      GoRoute(
        path: AppConstants.loginRoute,
        name: 'login',
        builder: (context, state) => const Placeholder(), // TODO: Replace with LoginPage
      ),
      GoRoute(
        path: AppConstants.moodRoute,
        name: 'mood',
        builder: (context, state) => const Placeholder(), // TODO: Replace with MoodPage
      ),
      GoRoute(
        path: AppConstants.analyticsRoute,
        name: 'analytics',
        builder: (context, state) => const Placeholder(), // TODO: Replace with AnalyticsPage
      ),
      GoRoute(
        path: AppConstants.settingsRoute,
        name: 'settings',
        builder: (context, state) => const Placeholder(), // TODO: Replace with SettingsPage
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.matchedLocation}'),
      ),
    ),
  );
}
