import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker_app/core/constants/app_constants.dart';

class AnalyticsPage extends ConsumerStatefulWidget {
  const AnalyticsPage({super.key});

  @override
  ConsumerState<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends ConsumerState<AnalyticsPage> {
  String _selectedPeriod = '7 days';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(AppConstants.homeRoute),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Period selector
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(
                  value: '7 days',
                  label: Text('Week'),
                  icon: Icon(Icons.calendar_view_week),
                ),
                ButtonSegment(
                  value: '30 days',
                  label: Text('Month'),
                  icon: Icon(Icons.calendar_view_month),
                ),
                ButtonSegment(
                  value: '365 days',
                  label: Text('Year'),
                  icon: Icon(Icons.calendar_today),
                ),
              ],
              selected: {_selectedPeriod},
              onSelectionChanged: (Set<String> selection) {
                setState(() => _selectedPeriod = selection.first);
              },
            ),
            const SizedBox(height: 24),

            // Mood distribution card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mood Distribution',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    _buildMoodDistribution(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Statistics cards
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Total Entries',
                    value: '42',
                    icon: Icons.event_note,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatCard(
                    title: 'Average Mood',
                    value: '3.8/5',
                    icon: Icons.trending_up,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Insights card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Insights',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildInsightItem(
                      context,
                      'Your mood tends to be higher on weekends',
                      Icons.weekend,
                    ),
                    _buildInsightItem(
                      context,
                      'Exercise correlates with better mood',
                      Icons.fitness_center,
                    ),
                    _buildInsightItem(
                      context,
                      'You track moods most frequently in the evening',
                      Icons.nightlight,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Export button
            OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Export feature coming soon!')),
                );
              },
              icon: const Icon(Icons.download),
              label: const Text('Export Data'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodDistribution() {
    // Sample data - replace with actual data from API
    final moodData = [
      {'mood': 'Very Happy', 'count': 8, 'color': const Color(0xFF4CAF50)},
      {'mood': 'Happy', 'count': 15, 'color': const Color(0xFF8BC34A)},
      {'mood': 'Neutral', 'count': 12, 'color': const Color(0xFFFFC107)},
      {'mood': 'Sad', 'count': 5, 'color': const Color(0xFFFF9800)},
      {'mood': 'Very Sad', 'count': 2, 'color': const Color(0xFFF44336)},
    ];

    final total = moodData.fold<int>(0, (sum, item) => sum + (item['count'] as int));

    return Column(
      children: moodData.map((item) {
        final percentage = ((item['count'] as int) / total * 100).toStringAsFixed(1);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  item['mood'] as String,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: (item['count'] as int) / total,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation(item['color'] as Color),
                    minHeight: 20,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 60,
                child: Text(
                  '$percentage%',
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInsightItem(BuildContext context, String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
