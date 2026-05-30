import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user_model.dart';

class AuthService {
  // Khởi tạo bộ lưu trữ file mã hóa an toàn của thiết bị
  final _storage = const FlutterSecureStorage();

  // CHỨC NĂNG ĐĂNG KÝ (Cần cả Object User gồm Full Name)
  Future<bool> register(UserModel user) async {
    // Đọc thử xem email này đã từng được tạo file chưa
    String? existingUser = await _storage.read(key: user.email);
    if (existingUser != null) {
      return false; // Email đã tồn tại, không cho đăng ký trùng
    }

    // Chuyển Object thành chuỗi JSON và ghi vào file với Key là email
    String userJson = jsonEncode(user.toJson());
    await _storage.write(key: user.email, value: userJson);
    return true;
  }

  // CHỨC NĂNG ĐĂNG NHẬP (Chỉ cần Email và Password)
  Future<bool> login(String email, String password) async {
    // Tìm file lưu trữ theo tên Key là Email
    String? userRaw = await _storage.read(key: email);
    if (userRaw == null) {
      return false; // Không tìm thấy tài khoản
    }

    // Giải mã chuỗi JSON thành Map dữ liệu
    Map<String, dynamic> userMap = jsonDecode(userRaw);
    UserModel user = UserModel.fromJson(userMap);

    // Kiểm tra mật khẩu nhập vào có trùng khớp với mật khẩu trong file không
    return user.password == password;
  }
}