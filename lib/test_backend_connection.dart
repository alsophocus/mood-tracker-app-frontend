import 'package:flutter/material.dart';
import 'package:mood_tracker_app/core/services/api_service.dart';
import 'package:mood_tracker_app/data/services/health_api_service.dart';
import 'package:mood_tracker_app/config/env/env_config.dart';

/// Test screen to verify backend connection
class BackendConnectionTest extends StatefulWidget {
  const BackendConnectionTest({super.key});

  @override
  State<BackendConnectionTest> createState() => _BackendConnectionTestState();
}

class _BackendConnectionTestState extends State<BackendConnectionTest> {
  final _apiService = ApiService();
  late final HealthApiService _healthService;
  String _status = 'Not tested';
  Color _statusColor = Colors.grey;
  List<String> _testResults = [];

  @override
  void initState() {
    super.initState();
    _healthService = HealthApiService(_apiService);
  }

  Future<void> _runTests() async {
    setState(() {
      _status = 'Testing...';
      _statusColor = Colors.orange;
      _testResults.clear();
    });

    final results = <String>[];

    // Test 1: Backend URL
    results.add('📡 Backend URL: ${EnvConfig.apiBaseUrl}');

    // Test 2: Health Check
    try {
      final healthResponse = await _healthService.checkHealth();
      if (healthResponse.success) {
        results.add('✅ Health Check: ${healthResponse.data?['status']}');
        results.add('   Database: ${healthResponse.data?['database']}');
      } else {
        results.add('❌ Health Check Failed: ${healthResponse.error}');
      }
    } catch (e) {
      results.add('❌ Health Check Error: $e');
    }

    // Test 3: API Info
    try {
      final apiInfoResponse = await _healthService.getApiInfo();
      if (apiInfoResponse.success) {
        results.add('✅ API Info: ${apiInfoResponse.data?['name']}');
        results.add('   Version: ${apiInfoResponse.data?['version']}');
      } else {
        results.add('❌ API Info Failed: ${apiInfoResponse.error}');
      }
    } catch (e) {
      results.add('❌ API Info Error: $e');
    }

    setState(() {
      _testResults = results;
      _status = results.any((r) => r.contains('❌'))
          ? 'Tests Failed'
          : 'All Tests Passed';
      _statusColor = results.any((r) => r.contains('❌'))
          ? Colors.red
          : Colors.green;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Backend Connection Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: _statusColor.withAlpha(25),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      _status,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: _statusColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Environment: ${EnvConfig.environment}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _runTests,
              icon: const Icon(Icons.play_arrow),
              label: const Text('Run Tests'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Card(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _testResults.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        _testResults[index],
                        style: const TextStyle(fontFamily: 'monospace'),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
