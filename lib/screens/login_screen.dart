import 'package:flutter/material.dart';
import '../utils/auth_service.dart';
import 'register_screen.dart';
import 'test_home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _stayInLane = false;

  void _handleLogin() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar("Vui lòng điền đầy đủ thông tin!");
      return;
    }

    bool success = await _authService.login(email, password);
    if (success) {
      _showSnackBar("Đăng nhập thành công! Đang vào Garage...", isSuccess: true);

      // Chuyển hướng sang màn hình Home/Game chính
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const TestHomeScreen()),
        );
      }
    } else {
      _showSnackBar("Tài khoản hoặc Secure Key không chính xác!");
    }
  }

  void _showSnackBar(String message, {bool isSuccess = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(message),
          backgroundColor: isSuccess ? Colors.green : const Color(0xFFB71C1C)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9EBE6), // Màu nền kem nhạt giống ảnh
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.sports_motorsports, size: 80, color: Color(0xFF1E1E1E)),
              const SizedBox(height: 12),
              const Text("PRO RACER", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFFB71C1C), fontStyle: FontStyle.italic)),
              const Text("HIGH-OCTANE ACADEMY", style: TextStyle(letterSpacing: 2, fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),

              // Khung Login Form
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 3),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("EMAIL", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: "RACER_01",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text("SECURE KEY", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "••••••••",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                    ),
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Checkbox(
                          value: _stayInLane,
                          onChanged: (val) => setState(() => _stayInLane = val ?? false),
                          activeColor: const Color(0xFFB71C1C),
                        ),
                        const Text("STAY IN THE LANE", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Nút START ENGINE
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB71C1C),
                          shape: const RoundedRectangleBorder(),
                        ),
                        onPressed: _handleLogin,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("START ENGINE ", style: TextStyle(color: Colors.white, fontSize: 20, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
                            Icon(Icons.flash_on, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
                        },
                        child: const Text("REGISTER FOR THE GRID →", style: TextStyle(color: Color(0xFFB71C1C), fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}