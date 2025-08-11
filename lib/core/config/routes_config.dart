import 'package:flutter/material.dart';
import 'package:hanae_app/ui/screens/auth/fitness_goal_screen.dart';
import 'package:hanae_app/ui/screens/auth/forgot_password_screen.dart';
import 'package:hanae_app/ui/screens/auth/login_screen.dart';
import 'package:hanae_app/ui/screens/auth/register_screen.dart';
import 'package:hanae_app/ui/screens/auth/role_selection_screen.dart';
import 'package:hanae_app/ui/screens/home/home_screen.dart';
import 'package:hanae_app/ui/screens/market/market_screen.dart';
import 'package:hanae_app/ui/screens/spalsh/splash_screen.dart';
import 'package:hanae_app/ui/screens/welcome/welcome_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const welcome = '/welcome';
  static const login = '/login';
  static const register = '/register';
  static const forgetPassword = '/forgetPassword';
  static const roleSelection = '/roleSelection';
  static const fitnessGoal = '/fitnessGoal';
  static const home = '/home';
  static const market = '/market';
}

final Map<String, WidgetBuilder> routes = {
  AppRoutes.splash: (context) => const SplashScreen(),
  AppRoutes.welcome: (context) => const WelcomeScreen(),
  AppRoutes.login: (context) => const LoginScreen(),
  AppRoutes.register: (context) => const RegisterScreen(),
  AppRoutes.forgetPassword: (context) => const ForgotPasswordScreen(),
  AppRoutes.roleSelection: (context) => const RoleSelectionScreen(),
  AppRoutes.fitnessGoal: (context) => const FitnessGoalScreen(),
  AppRoutes.home: (context) => const HomeScreen(),
  AppRoutes.market: (context) => const MarketScreen(),
};