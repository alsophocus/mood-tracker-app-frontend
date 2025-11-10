import 'package:dio/dio.dart';
import 'package:mood_tracker_app/core/services/api_service.dart';
import 'package:mood_tracker_app/data/models/api_response.dart';

class AnalyticsApiService {
  final ApiService _apiService;

  AnalyticsApiService(this._apiService);

  /// Get mood distribution for last N days
  Future<ApiResponse<Map<String, dynamic>>> getMoodDistribution({int days = 30}) async {
    try {
      final response = await _apiService.get(
        '/api/analytics/distribution',
        queryParameters: {'days': days},
      );

      if (response.statusCode == 200) {
        return ApiResponse.fromJson(response.data, (data) => data as Map<String, dynamic>);
      }

      return ApiResponse.failure('Failed to fetch mood distribution');
    } on DioException catch (e) {
      return ApiResponse.failure(e.response?.data['error'] ?? 'Network error');
    }
  }

  /// Get average mood for last N days
  Future<ApiResponse<Map<String, dynamic>>> getAverageMood({int days = 30}) async {
    try {
      final response = await _apiService.get(
        '/api/analytics/average',
        queryParameters: {'days': days},
      );

      if (response.statusCode == 200) {
        return ApiResponse.fromJson(response.data, (data) => data as Map<String, dynamic>);
      }

      return ApiResponse.failure('Failed to fetch average mood');
    } on DioException catch (e) {
      return ApiResponse.failure(e.response?.data['error'] ?? 'Network error');
    }
  }

  /// Get mood trends
  Future<ApiResponse<Map<String, dynamic>>> getTrends({int days = 30}) async {
    try {
      final response = await _apiService.get(
        '/api/analytics/trends',
        queryParameters: {'days': days},
      );

      if (response.statusCode == 200) {
        return ApiResponse.fromJson(response.data, (data) => data as Map<String, dynamic>);
      }

      return ApiResponse.failure('Failed to fetch trends');
    } on DioException catch (e) {
      return ApiResponse.failure(e.response?.data['error'] ?? 'Network error');
    }
  }

  /// Get hourly patterns
  Future<ApiResponse<Map<String, dynamic>>> getHourlyPatterns({int days = 30}) async {
    try {
      final response = await _apiService.get(
        '/api/analytics/hourly-patterns',
        queryParameters: {'days': days},
      );

      if (response.statusCode == 200) {
        return ApiResponse.fromJson(response.data, (data) => data as Map<String, dynamic>);
      }

      return ApiResponse.failure('Failed to fetch hourly patterns');
    } on DioException catch (e) {
      return ApiResponse.failure(e.response?.data['error'] ?? 'Network error');
    }
  }

  /// Get quick stats overview
  Future<ApiResponse<Map<String, dynamic>>> getQuickStats() async {
    try {
      final response = await _apiService.get('/api/analytics/quick-stats');

      if (response.statusCode == 200) {
        return ApiResponse.fromJson(response.data, (data) => data as Map<String, dynamic>);
      }

      return ApiResponse.failure('Failed to fetch quick stats');
    } on DioException catch (e) {
      return ApiResponse.failure(e.response?.data['error'] ?? 'Network error');
    }
  }

  /// Compare current week vs previous week
  Future<ApiResponse<Map<String, dynamic>>> getWeekComparison() async {
    try {
      final response = await _apiService.get('/api/analytics/week-comparison');

      if (response.statusCode == 200) {
        return ApiResponse.fromJson(response.data, (data) => data as Map<String, dynamic>);
      }

      return ApiResponse.failure('Failed to fetch week comparison');
    } on DioException catch (e) {
      return ApiResponse.failure(e.response?.data['error'] ?? 'Network error');
    }
  }
}
