import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  EnvConfig._();

  static Future<void> load() async {
    await dotenv.load(fileName: '.env');
  }

  static String get apiBaseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'http://localhost:5000/api';

  static int get apiTimeout =>
      int.tryParse(dotenv.env['API_TIMEOUT'] ?? '30000') ?? 30000;

  static String get environment =>
      dotenv.env['ENVIRONMENT'] ?? 'development';

  static bool get isDevelopment => environment == 'development';
  static bool get isProduction => environment == 'production';
}
