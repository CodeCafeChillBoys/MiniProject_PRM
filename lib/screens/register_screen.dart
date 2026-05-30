import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../utils/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _authService = AuthService();

  void _handleRegister() async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text;
    String confirm = _confirmPasswordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirm.isEmpty) {
      _showSnackBar("Vui lòng nhập đầy đủ thông tin!");
      return;
    }

    if (password != confirm) {
      _showSnackBar("Mật khẩu xác nhận không khớp!");
      return;
    }

    // Đóng gói dữ liệu vào Model bao gồm cả Full Name
    UserModel newRacer = UserModel(
      fullName: name,
      email: email,
      password: password,
    );

    bool isSuccess = await _authService.register(newRacer);
    if (isSuccess) {
      _showSnackBar("Tạo tài khoản thành công!", isSuccess: true);
      if (mounted) Navigator.pop(context); // Quay lại màn hình đăng nhập
    } else {
      _showSnackBar("Email này đã được đăng ký trước đó!");
    }
  }

  void _showSnackBar(String message, {bool isSuccess = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: isSuccess ? Colors.green : const Color(0xFFB71C1C)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9EBE6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const Text("JOIN THE GRID", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Color(0xFF1E1E1E))),
            const SizedBox(height: 8),
            const Text("Complete your profile to start racing.", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("FULL NAME", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "John 'Turbo' Doe"),
                  ),
                  const SizedBox(height: 20),

                  const Text("EMAIL ADDRESS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "racer@circuit.com"),
                  ),
                  const SizedBox(height: 20),

                  const Text("PASSWORD", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "••••••••"),
                  ),
                  const SizedBox(height: 20),

                  const Text("CONFIRM PASSWORD", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "••••••••"),
                  ),
                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB71C1C),
                        shape: const RoundedRectangleBorder(),
                      ),
                      onPressed: _handleRegister,
                      child: const Text("CREATE ACCOUNT", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}