import 'package:dio/dio.dart';
import 'package:mood_tracker_app/core/services/api_service.dart';
import 'package:mood_tracker_app/data/models/api_response.dart';

class HealthApiService {
  final ApiService _apiService;

  HealthApiService(this._apiService);

  /// Check backend health status
  Future<ApiResponse<Map<String, dynamic>>> checkHealth() async {
    try {
      final response = await _apiService.get('/health');

      if (response.statusCode == 200) {
        return ApiResponse.success(response.data as Map<String, dynamic>);
      }

      return ApiResponse.failure('Backend unhealthy');
    } on DioException catch (e) {
      return ApiResponse.failure(e.response?.data?['error'] ?? 'Cannot connect to backend');
    }
  }

  /// Get API info
  Future<ApiResponse<Map<String, dynamic>>> getApiInfo() async {
    try {
      final response = await _apiService.get('/api');

      if (response.statusCode == 200) {
        return ApiResponse.success(response.data as Map<String, dynamic>);
      }

      return ApiResponse.failure('Failed to fetch API info');
    } on DioException catch (e) {
      return ApiResponse.failure(e.response?.data?['error'] ?? 'Network error');
    }
  }
}
