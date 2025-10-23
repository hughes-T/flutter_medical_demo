import 'package:flutter/material.dart';
import '../features/splash/presentation/pages/splash_page.dart';
import '../features/onboarding/presentation/pages/onboarding_page.dart';
import '../features/auth/presentation/pages/login_phone_page.dart';
import '../features/auth/presentation/pages/login_verification_page.dart';
import '../features/auth/presentation/pages/user_info_page.dart';
import '../features/home/presentation/pages/main_page.dart';

class AppRoutes {
  // Route names
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String loginPhone = '/login-phone';
  static const String loginVerification = '/login-verification';
  static const String userInfo = '/user-info';
  static const String home = '/home';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());

      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());

      case loginPhone:
        return MaterialPageRoute(builder: (_) => const LoginPhonePage());

      case loginVerification:
        final phoneNumber = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => LoginVerificationPage(phoneNumber: phoneNumber),
        );

      case userInfo:
        return MaterialPageRoute(builder: (_) => const UserInfoPage());

      case home:
        return MaterialPageRoute(builder: (_) => const MainPage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
