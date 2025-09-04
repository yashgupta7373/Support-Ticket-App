import 'package:fintechticket/screens/splesh_screen.dart';
import 'package:fintechticket/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neobyt',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(primarySwatch: AppColors.primary),
      home: FutureBuilder<bool>(
        future: checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else {
            if (snapshot.data == true) {
              return DashboardScreen();
            } else {
              return const LoginScreen();
            }
          }
        },
      ),
    );
  }
}
