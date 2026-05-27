import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Giao diện đầu tiên',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyLayoutScreen(), // Gọi trang giao diện của bạn ở đây
    );
  }
}

class MyLayoutScreen extends StatelessWidget {
  const MyLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thiết kế Layout'),
      ),
      body: const Center(
        child: Text('Bắt đầu code giao diện tại đây!'),
      ),
    );
  }
}