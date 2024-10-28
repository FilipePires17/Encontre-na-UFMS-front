import '../../config/environment/environment.dart';

abstract class ApiUrls {
  // Locations
  static const String baseLocations = '$baseUrlDev/locales';
  static const String toggleFavorite = '$baseLocations/favorites';
  static const String locationSection = '$baseLocations/section';

  // Auth
  static const String baseAuth = '$baseUrlDev/auth';
  static const String signIn = '$baseAuth/login';
  static const String refreshToken = '$baseAuth/refresh';
  static const String validateUrl = '$baseAuth/verify';
  static const String register = '$baseAuth/register';
  static const String sendVerificationEmail = '$baseAuth/forgot-password';
  static const String verifyRedefinitionCode =
      '$sendVerificationEmail/validate-token';

  // User
  static const String baseUser = '$baseUrlDev/users';
  static const String editProfileUrl = '$baseUser/edit';
}
