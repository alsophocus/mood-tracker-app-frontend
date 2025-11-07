class AppConstants {
  // Private constructor
  AppConstants._();

  // App Info
  static const String appName = 'Mood Tracker';
  static const String appVersion = '1.0.0';

  // API
  static const int apiTimeout = 30;
  static const String apiVersion = 'v1';

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String themeKey = 'theme_mode';

  // Routes
  static const String homeRoute = '/';
  static const String loginRoute = '/login';
  static const String moodRoute = '/mood';
  static const String analyticsRoute = '/analytics';
  static const String settingsRoute = '/settings';

  // Mood Values
  static const List<String> moodTypes = [
    'Very Happy',
    'Happy',
    'Neutral',
    'Sad',
    'Very Sad',
  ];

  // Date Formats
  static const String dateFormat = 'yyyy-MM-dd';
  static const String displayDateFormat = 'MMM dd, yyyy';
  static const String timeFormat = 'HH:mm';
}
