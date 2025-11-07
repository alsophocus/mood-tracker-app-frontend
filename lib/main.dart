import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker_app/app.dart';
import 'package:mood_tracker_app/config/env/env_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment configuration
  await EnvConfig.load();

  runApp(
    const ProviderScope(
      child: MoodTrackerApp(),
    ),
  );
}
