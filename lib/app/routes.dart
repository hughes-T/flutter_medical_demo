import 'package:flutter/material.dart';
import '../features/splash/presentation/pages/splash_page.dart';
import '../features/onboarding/presentation/pages/onboarding_page.dart';
import '../features/auth/presentation/pages/login_phone_page.dart';
import '../features/auth/presentation/pages/login_verification_page.dart';
import '../features/auth/presentation/pages/user_info_page.dart';
import '../features/device/presentation/pages/device_connection_page.dart';
import '../features/version/presentation/pages/version_selection_page.dart';
import '../features/prescription/presentation/pages/doctor_prescription_page.dart';
import '../features/questionnaire/presentation/pages/questionnaire_page.dart';
import '../features/home/presentation/pages/main_page.dart';
import '../features/home/presentation/pages/new_home_page.dart';
import '../features/training/presentation/pages/child_training_page.dart';

class AppRoutes {
  // Route names
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String loginPhone = '/login-phone';
  static const String loginVerification = '/login-verification';
  static const String userInfo = '/user-info';
  static const String deviceConnection = '/device-connection';
  static const String versionSelection = '/version-selection';
  static const String doctorPrescription = '/doctor-prescription';
  static const String questionnaire = '/questionnaire';
  static const String home = '/home';
  static const String training = '/training';

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

      case deviceConnection:
        return MaterialPageRoute(builder: (_) => const DeviceConnectionPage());

      case versionSelection:
        return MaterialPageRoute(builder: (_) => const VersionSelectionPage());

      case doctorPrescription:
        final version = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => DoctorPrescriptionPage(version: version),
        );

      case questionnaire:
        final version = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => QuestionnairePage(version: version),
        );

      case home:
        final args = settings.arguments;
        String version = '儿童版';
        int initialTabIndex = 0;

        if (args is String) {
          version = args;
        } else if (args is Map<String, dynamic>) {
          version = args['version'] as String? ?? '儿童版';
          initialTabIndex = args['initialTabIndex'] as int? ?? 0;
        }

        return MaterialPageRoute(
          builder: (_) => MainPage(
            version: version,
            initialTabIndex: initialTabIndex,
          ),
        );

      case training:
        final args = settings.arguments as Map<String, dynamic>;
        final version = args['version'] as String;
        final type = args['type'] as String;
        return MaterialPageRoute(
          builder: (_) => ChildTrainingPage(version: version, trainingType: type),
        );

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
