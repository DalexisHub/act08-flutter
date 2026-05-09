import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const NexoPersonasApp());
}

class NexoPersonasApp extends StatelessWidget {
  const NexoPersonasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nexo Personas',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Arial',
        scaffoldBackgroundColor: const Color(0xFF18383D),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFCADBDD),
          brightness: Brightness.dark,
        ),
      ),
    );
  }
}
