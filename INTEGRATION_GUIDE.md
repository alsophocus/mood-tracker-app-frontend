# Frontend-Backend Integration Guide

## ✅ Integration Complete!

The Flutter frontend is now fully integrated with the Railway backend.

---

## 🌐 Backend Information

**Production Backend:**
- URL: `https://mood-tracker-app-backend-production.up.railway.app`
- Status: ✅ LIVE
- Database: ✅ Connected (PostgreSQL)
- API Version: 2.0.0

**Health Check:**
```bash
curl https://mood-tracker-app-backend-production.up.railway.app/health
```

---

## 📁 Frontend Structure Created

### Models (`lib/data/models/`)
- ✅ `mood_model.dart` - Mood entry with context
- ✅ `tag_model.dart` - Tag and categories
- ✅ `user_model.dart` - User information
- ✅ `api_response.dart` - Standard API response wrapper

### API Services (`lib/data/services/`)
- ✅ `mood_api_service.dart` - Mood CRUD operations
- ✅ `analytics_api_service.dart` - Analytics & statistics
- ✅ `tag_api_service.dart` - Tag management
- ✅ `health_api_service.dart` - Health checks

### Core Services (`lib/core/services/`)
- ✅ `api_service.dart` - Base HTTP client (Dio)

### Configuration
- ✅ `.env` - Development environment (pointing to Railway)
- ✅ `.env.production` - Production environment
- ✅ `env_config.dart` - Environment configuration loader

---

## 🚀 How to Use

### 1. Test Backend Connection

Add this to your app for testing:

```dart
import 'package:mood_tracker_app/test_backend_connection.dart';

// In your app, add a test route
MaterialApp(
  routes: {
    '/test': (context) => const BackendConnectionTest(),
  },
)
```

### 2. Use API Services

#### Example: Create a Mood

```dart
import 'package:mood_tracker_app/core/services/api_service.dart';
import 'package:mood_tracker_app/data/services/mood_api_service.dart';
import 'package:mood_tracker_app/data/models/mood_model.dart';

// Initialize services
final apiService = ApiService();
final moodService = MoodApiService(apiService);

// Create mood
final mood = MoodModel(
  userId: 1,
  date: DateTime.now().toIso8601String().split('T')[0],
  mood: 'well',
  moodValue: 6,
  notes: 'Feeling great today!',
  triggers: '',
  context: MoodContext(
    location: 'home',
    activity: 'working',
    weather: 'sunny',
  ),
  timestamp: DateTime.now().toIso8601String(),
  hour: DateTime.now().hour,
);

final response = await moodService.createMood(mood);
if (response.success) {
  print('Mood created: ${response.data}');
} else {
  print('Error: ${response.error}');
}
```

#### Example: Get Analytics

```dart
import 'package:mood_tracker_app/data/services/analytics_api_service.dart';

final analyticsService = AnalyticsApiService(apiService);

// Get quick stats
final stats = await analyticsService.getQuickStats();
if (stats.success) {
  print('Total moods: ${stats.data?['total_entries']}');
  print('Week average: ${stats.data?['week_average']}');
}

// Get mood distribution
final distribution = await analyticsService.getMoodDistribution(days: 30);
if (distribution.success) {
  print('Distribution: ${distribution.data?['distribution']}');
}
```

#### Example: Manage Tags

```dart
import 'package:mood_tracker_app/data/services/tag_api_service.dart';

final tagService = TagApiService(apiService);

// Get all tags
final tagsResponse = await tagService.getAllTags();
if (tagsResponse.success) {
  final categories = tagsResponse.data?.categories;
  categories?.forEach((category, tags) {
    print('$category: ${tags.map((t) => t.name).join(", ")}');
  });
}

// Set tags for a mood
await tagService.setMoodTags(moodId, ['work', 'exercise', 'friends']);
```

---

## 🔧 Configuration Options

### Development (Local Backend)

If running backend locally with Docker:

```env
# .env
API_BASE_URL=http://localhost:5000
ENVIRONMENT=development
```

### Android Emulator (Local Backend)

```env
# .env
API_BASE_URL=http://10.0.2.2:5000
ENVIRONMENT=development
```

### Production (Railway)

```env
# .env
API_BASE_URL=https://mood-tracker-app-backend-production.up.railway.app
ENVIRONMENT=production
```

---

## 📡 Available API Endpoints

### Authentication
- `GET /api/auth/oauth/<provider>` - Get OAuth URL
- `GET /api/auth/callback/<provider>` - OAuth callback
- `POST /api/auth/logout` - Logout
- `GET /api/auth/me` - Get current user

### Moods
- `POST /api/moods` - Create mood
- `GET /api/moods` - List moods (with pagination)
- `GET /api/moods/recent` - Get recent mood
- `PUT /api/moods/<id>` - Update mood
- `DELETE /api/moods/<id>` - Delete mood

### Tags
- `GET /api/tags` - Get all tags (grouped by category)
- `POST /api/tags` - Create tag
- `GET /api/tags/mood/<id>` - Get mood tags
- `PUT /api/tags/mood/<id>` - Set mood tags

### Analytics
- `GET /api/analytics/distribution?days=30` - Mood distribution
- `GET /api/analytics/average?days=30` - Average mood
- `GET /api/analytics/trends?days=30` - Mood trends
- `GET /api/analytics/hourly-patterns?days=30` - Hourly patterns
- `GET /api/analytics/quick-stats` - Quick overview
- `GET /api/analytics/week-comparison` - Week comparison

### Insights
- `GET /api/insights` - Get personalized insights
- `GET /api/insights/tag-correlations` - Tag-mood correlations

### Export
- `GET /api/export/json?days=30` - Export as JSON
- `GET /api/export/csv?days=30` - Export as CSV
- `GET /api/export/summary?days=30` - Get summary stats

---

## 🧪 Testing

### Run Connection Test

```dart
// Navigate to test screen
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const BackendConnectionTest(),
  ),
);
```

### Manual Testing with cURL

```bash
# Health check
curl https://mood-tracker-app-backend-production.up.railway.app/health

# API info
curl https://mood-tracker-app-backend-production.up.railway.app/api
```

---

## 🐛 Troubleshooting

### Connection Errors

**Problem:** Cannot connect to backend

**Solutions:**
1. Check `.env` file has correct `API_BASE_URL`
2. Verify backend is running: `curl <API_BASE_URL>/health`
3. Check network permissions in `AndroidManifest.xml`:
   ```xml
   <uses-permission android:name="android.permission.INTERNET"/>
   ```

### CORS Errors

**Problem:** CORS policy blocks requests

**Solution:** Backend already has CORS enabled for all origins. If issues persist, check browser console for specific errors.

### Authentication Required

**Problem:** 401 Unauthorized errors

**Solution:** Most endpoints require authentication. Implement OAuth flow first:
1. Use `/api/auth/oauth/<provider>` to get OAuth URL
2. Complete OAuth flow
3. API service will manage session cookies

---

## 📦 Dependencies

Make sure `pubspec.yaml` has:

```yaml
dependencies:
  flutter:
    sdk: flutter
  dio: ^5.4.0
  flutter_dotenv: ^5.1.0
```

---

## 🎯 Next Steps

1. ✅ Backend deployed and running
2. ✅ Frontend models created
3. ✅ API services implemented
4. ⏭️ Implement UI screens
5. ⏭️ Add OAuth authentication
6. ⏭️ Build mood tracking interface
7. ⏭️ Create analytics dashboard
8. ⏭️ Add tag management
9. ⏭️ Implement insights view
10. ⏭️ Add data export features

---

## 📝 Example Integration Flow

```dart
// 1. Initialize services in main app
class MyApp extends StatelessWidget {
  final apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => MoodApiService(apiService),
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}

// 2. Use in screens
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moodService = Provider.of<MoodApiService>(context);

    return FutureBuilder(
      future: moodService.getRecentMood(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final mood = snapshot.data?.data;
          return Text('Recent mood: ${mood?.mood}');
        }
        return CircularProgressIndicator();
      },
    );
  }
}
```

---

## ✅ Integration Checklist

- [x] Backend deployed to Railway
- [x] Database connected
- [x] Frontend `.env` configured
- [x] API models created
- [x] API services implemented
- [x] Test file created
- [ ] OAuth authentication implemented
- [ ] UI screens built
- [ ] Full end-to-end testing

**Status: Ready for UI Development! 🎉**
