import 'package:grad_dashboard/modules/auth/login/login_screen.dart';
import 'package:grad_dashboard/modules/home/home_screen.dart';
import 'package:grad_dashboard/modules/splash/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
}

final routes = {
  AppRoutes.splash: (context) => const SplashScreen(),
  AppRoutes.login: (context) => const LoginScreen(),
  AppRoutes.home: (context) => const HomeScreen(),
};
