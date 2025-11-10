import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker_app/core/constants/app_constants.dart';

class MoodPage extends ConsumerStatefulWidget {
  const MoodPage({super.key});

  @override
  ConsumerState<MoodPage> createState() => _MoodPageState();
}

class _MoodPageState extends ConsumerState<MoodPage> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();
  int _selectedMood = 2; // Default to Neutral
  final List<String> _selectedTags = [];
  bool _isLoading = false;

  final List<IconData> _moodIcons = [
    Icons.sentiment_very_satisfied,
    Icons.sentiment_satisfied,
    Icons.sentiment_neutral,
    Icons.sentiment_dissatisfied,
    Icons.sentiment_very_dissatisfied,
  ];

  final List<Color> _moodColors = [
    const Color(0xFF4CAF50), // Green - Very Happy
    const Color(0xFF8BC34A), // Light Green - Happy
    const Color(0xFFFFC107), // Amber - Neutral
    const Color(0xFFFF9800), // Orange - Sad
    const Color(0xFFF44336), // Red - Very Sad
  ];

  final List<String> _availableTags = [
    'Work',
    'Family',
    'Friends',
    'Health',
    'Exercise',
    'Sleep',
    'Food',
    'Weather',
    'Stress',
    'Relaxation',
  ];

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _saveMood() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // TODO: Implement actual mood saving with backend API
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mood entry saved successfully!')),
        );
        context.go(AppConstants.homeRoute);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save mood: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Mood Entry'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go(AppConstants.homeRoute),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'How are you feeling?',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 24),

              // Mood selector
              Center(
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: List.generate(
                    AppConstants.moodTypes.length,
                    (index) => _MoodButton(
                      label: AppConstants.moodTypes[index],
                      icon: _moodIcons[index],
                      color: _moodColors[index],
                      isSelected: _selectedMood == index,
                      onTap: () => setState(() => _selectedMood = index),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Notes
              Text(
                'Notes (optional)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _notesController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Add any thoughts or context...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 32),

              // Tags
              Text(
                'Tags (optional)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _availableTags.map((tag) {
                  final isSelected = _selectedTags.contains(tag);
                  return FilterChip(
                    label: Text(tag),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedTags.add(tag);
                        } else {
                          _selectedTags.remove(tag);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),

              // Save button
              FilledButton(
                onPressed: _isLoading ? null : _saveMood,
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Save Mood Entry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MoodButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _MoodButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.2) : Colors.transparent,
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 48,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
