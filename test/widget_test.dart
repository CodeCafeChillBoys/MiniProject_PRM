import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Đã sửa thành 'miniproject' khớp hoàn toàn với pubspec.yaml của bạn
import 'package:miniproject/main.dart';

void main() {
  testWidgets('Pro Racer App Smoke Test', (WidgetTester tester) async {
    // Khởi chạy ứng dụng ProRacerApp
    await tester.pumpWidget(const ProRacerApp());

    // Kiểm tra xem màn hình login có hiển thị đúng các text đặc trưng không
    expect(find.text('PRO RACER'), findsOneWidget);
    expect(find.text('START ENGINE '), findsOneWidget);

    // Kiểm tra xem có ô nhập liệu hay không
    expect(find.byType(TextField), findsNWidgets(2)); // Ô Email và ô Password
  });
}