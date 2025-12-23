import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/register_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/language_selection_screen.dart';
import 'screens/notification_screen.dart';
import 'screens/announcement_list_screen.dart';
import 'screens/announcement_detail_screen.dart';
import 'screens/class_list_screen.dart';
import 'screens/class_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LMS Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/language': (context) => const LanguageSelectionScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/register': (context) => const RegisterScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/notification': (context) => const NotificationScreen(),
        '/announcement_list': (context) => const AnnouncementListScreen(),
        '/announcement_detail': (context) => const AnnouncementDetailScreen(),
        '/class_list': (context) => const ClassListScreen(),
        '/class_detail': (context) => const ClassDetailScreen(),
      },
    );
  }
}
