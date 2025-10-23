class AppConstants {
  // App Info
  static const String appName = 'Medical Training';
  static const String appVersion = '1.0.0';

  // Storage Keys
  static const String keyFirstLaunch = 'first_launch';
  static const String keyUserToken = 'user_token';
  static const String keyUserInfo = 'user_info';
  static const String keyIsLoggedIn = 'is_logged_in';

  // API Configuration
  static const String baseUrl = 'https://api.example.com'; // 替换为实际API地址
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;

  // Validation
  static const int phoneNumberLength = 11;
  static const int verificationCodeLength = 6;
  static const int verificationCodeResendSeconds = 60;

  // Onboarding
  static const int onboardingPageCount = 2;
}
