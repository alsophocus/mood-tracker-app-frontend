import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker_app/core/constants/app_constants.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics),
            onPressed: () => context.go(AppConstants.analyticsRoute),
            tooltip: 'Analytics',
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.go(AppConstants.settingsRoute),
            tooltip: 'Settings',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sentiment_satisfied_alt,
              size: 100,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              'How are you feeling today?',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text(
              'Track your mood and gain insights',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 48),
            FilledButton.icon(
              onPressed: () => context.go(AppConstants.moodRoute),
              icon: const Icon(Icons.add),
              label: const Text('Add Mood Entry'),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () => context.go(AppConstants.analyticsRoute),
              icon: const Icon(Icons.insights),
              label: const Text('View Analytics'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go(AppConstants.moodRoute),
        child: const Icon(Icons.add),
      ),
    );
  }
}
