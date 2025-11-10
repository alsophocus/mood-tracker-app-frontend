import 'package:dio/dio.dart';
import 'package:mood_tracker_app/core/services/api_service.dart';
import 'package:mood_tracker_app/data/models/mood_model.dart';
import 'package:mood_tracker_app/data/models/api_response.dart';

class MoodApiService {
  final ApiService _apiService;

  MoodApiService(this._apiService);

  /// Create a new mood entry
  Future<ApiResponse<MoodModel>> createMood(MoodModel mood) async {
    try {
      final response = await _apiService.post(
        '/api/moods',
        data: mood.toCreateJson(),
      );

      if (response.statusCode == 200) {
        return ApiResponse.fromJson(
          response.data,
          (data) => MoodModel.fromJson(data),
        );
      }

      return ApiResponse.failure('Failed to create mood');
    } on DioException catch (e) {
      return ApiResponse.failure(e.response?.data['error'] ?? 'Network error');
    }
  }

  /// Get all moods for current user
  Future<ApiResponse<List<MoodModel>>> getMoods({
    int? limit,
    int offset = 0,
    String? startDate,
    String? endDate,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (limit != null) queryParams['limit'] = limit;
      if (offset > 0) queryParams['offset'] = offset;
      if (startDate != null) queryParams['start_date'] = startDate;
      if (endDate != null) queryParams['end_date'] = endDate;

      final response = await _apiService.get(
        '/api/moods',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return ApiResponse.fromJson(
          response.data,
          (data) => (data as List).map((e) => MoodModel.fromJson(e)).toList(),
        );
      }

      return ApiResponse.failure('Failed to fetch moods');
    } on DioException catch (e) {
      return ApiResponse.failure(e.response?.data['error'] ?? 'Network error');
    }
  }

  /// Get most recent mood
  Future<ApiResponse<MoodModel?>> getRecentMood() async {
    try {
      final response = await _apiService.get('/api/moods/recent');

      if (response.statusCode == 200) {
        return ApiResponse.fromJson(
          response.data,
          (data) => data != null ? MoodModel.fromJson(data) : null,
        );
      }

      return ApiResponse.failure('Failed to fetch recent mood');
    } on DioException catch (e) {
      return ApiResponse.failure(e.response?.data['error'] ?? 'Network error');
    }
  }

  /// Update a mood entry
  Future<ApiResponse<MoodModel>> updateMood(int id, Map<String, dynamic> updates) async {
    try {
      final response = await _apiService.put(
        '/api/moods/$id',
        data: updates,
      );

      if (response.statusCode == 200) {
        return ApiResponse.fromJson(
          response.data,
          (data) => MoodModel.fromJson(data),
        );
      }

      return ApiResponse.failure('Failed to update mood');
    } on DioException catch (e) {
      return ApiResponse.failure(e.response?.data['error'] ?? 'Network error');
    }
  }

  /// Delete a mood entry
  Future<ApiResponse<bool>> deleteMood(int id) async {
    try {
      final response = await _apiService.delete('/api/moods/$id');

      if (response.statusCode == 200) {
        return ApiResponse.success(true, message: 'Mood deleted successfully');
      }

      return ApiResponse.failure('Failed to delete mood');
    } on DioException catch (e) {
      return ApiResponse.failure(e.response?.data['error'] ?? 'Network error');
    }
  }
}
