import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/route_manager.dart';
import 'package:hanae_app/core/config/routes_config.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/ui/screens/auth/fitness_goal_screen.dart';
import 'package:hanae_app/ui/screens/auth/forgot_password_screen.dart';
import 'package:hanae_app/ui/screens/auth/login_screen.dart';
import 'package:hanae_app/ui/screens/auth/register_screen.dart';
import 'package:hanae_app/ui/screens/auth/role_selection_screen.dart';
import 'package:hanae_app/ui/screens/home/home_screen.dart';
import 'package:hanae_app/ui/screens/market/market_screen.dart';
import 'package:hanae_app/ui/screens/spalsh/splash_screen.dart';
import 'package:hanae_app/ui/screens/welcome/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Hanae App',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      locale: const Locale('en'),
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates: const[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: AppRoutes.splash,
      getPages: [
        GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
        GetPage(name: AppRoutes.welcome, page: () => const WelcomeScreen()),
        GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
        GetPage(name: AppRoutes.register, page: () => const RegisterScreen()),
        GetPage(name: AppRoutes.forgetPassword, page: () => const ForgotPasswordScreen()),
        GetPage(name: AppRoutes.roleSelection, page: () => const RoleSelectionScreen()),
        GetPage(name: AppRoutes.fitnessGoal, page: () => const FitnessGoalScreen()),
        GetPage(name: AppRoutes.home, page: () => const HomeScreen()),
        GetPage(name: AppRoutes.market, page: () => const MarketScreen()),
      ],
      
    );
  }
}

