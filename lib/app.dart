import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker_app/config/routes/app_router.dart';
import 'package:mood_tracker_app/core/constants/app_constants.dart';
import 'package:mood_tracker_app/core/theme/app_theme.dart';

class MoodTrackerApp extends ConsumerWidget {
  const MoodTrackerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}
