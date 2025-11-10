import 'package:dio/dio.dart';
import 'package:mood_tracker_app/core/services/api_service.dart';
import 'package:mood_tracker_app/data/models/tag_model.dart';
import 'package:mood_tracker_app/data/models/api_response.dart';

class TagApiService {
  final ApiService _apiService;

  TagApiService(this._apiService);

  /// Get all tags grouped by category
  Future<ApiResponse<TagCategoriesResponse>> getAllTags() async {
    try {
      final response = await _apiService.get('/api/tags');

      if (response.statusCode == 200) {
        return ApiResponse.fromJson(
          response.data,
          (data) => TagCategoriesResponse.fromJson(data['categories']),
        );
      }

      return ApiResponse.failure('Failed to fetch tags');
    } on DioException catch (e) {
      return ApiResponse.failure(e.response?.data['error'] ?? 'Network error');
    }
  }

  /// Create a new tag
  Future<ApiResponse<TagModel>> createTag(TagModel tag) async {
    try {
      final response = await _apiService.post(
        '/api/tags',
        data: {
          'name': tag.name,
          'category': tag.category,
          'color': tag.color,
          'icon': tag.icon,
        },
      );

      if (response.statusCode == 200) {
        return ApiResponse.fromJson(
          response.data,
          (data) => TagModel.fromJson(data),
        );
      }

      return ApiResponse.failure('Failed to create tag');
    } on DioException catch (e) {
      return ApiResponse.failure(e.response?.data['error'] ?? 'Network error');
    }
  }

  /// Get tags for a specific mood
  Future<ApiResponse<List<TagModel>>> getMoodTags(int moodId) async {
    try {
      final response = await _apiService.get('/api/tags/mood/$moodId');

      if (response.statusCode == 200) {
        return ApiResponse.fromJson(
          response.data,
          (data) => (data as List).map((e) => TagModel.fromJson(e)).toList(),
        );
      }

      return ApiResponse.failure('Failed to fetch mood tags');
    } on DioException catch (e) {
      return ApiResponse.failure(e.response?.data['error'] ?? 'Network error');
    }
  }

  /// Set tags for a mood
  Future<ApiResponse<bool>> setMoodTags(int moodId, List<String> tags) async {
    try {
      final response = await _apiService.put(
        '/api/tags/mood/$moodId',
        data: {'tags': tags},
      );

      if (response.statusCode == 200) {
        return ApiResponse.success(true, message: 'Tags updated successfully');
      }

      return ApiResponse.failure('Failed to set mood tags');
    } on DioException catch (e) {
      return ApiResponse.failure(e.response?.data['error'] ?? 'Network error');
    }
  }
}
