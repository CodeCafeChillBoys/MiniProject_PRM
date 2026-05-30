import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const ProRacerApp());
}

class ProRacerApp extends StatelessWidget {
  const ProRacerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pro Racer Simulations',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Roboto', // Bạn có thể tùy biến Font thể thao sau này
      ),
      home: const LoginScreen(), // Điểm khởi chạy ứng dụng
    );
  }
}