import '../../config/environment/environment.dart';

abstract class ApiUrls {
  // Locations
  static const String baseLocations = '$baseUrlDev/locales';
  static const String toggleFavorite = '$baseLocations/favorites';

  // Auth
  static const String baseAuth = '$baseUrlDev/auth';
  static const String signIn = '$baseAuth/login';
  static const String refreshToken = '$baseAuth/refresh';
}
