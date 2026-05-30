import 'package:flutter/material.dart';

class MovingBackground extends StatefulWidget {
  final Widget child;
  final bool isMoving; // Biến kiểm soát nền cuộn hay dừng

  const MovingBackground({
    super.key, 
    required this.child, 
    this.isMoving = true,
  });

  @override
  State<MovingBackground> createState() => _MovingBackgroundState();
}

class _MovingBackgroundState extends State<MovingBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500), // Thời gian 1 vòng cuộn (càng nhỏ càng nhanh)
    );
    if (widget.isMoving) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(MovingBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isMoving && !oldWidget.isMoving) {
      _controller.repeat();
    } else if (!widget.isMoving && oldWidget.isMoving) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final size = MediaQuery.of(context).size;
        return Stack(
          children: [
            // Tấm ảnh thứ nhất đang trượt xuống
            Positioned(
              left: 0,
              right: 0,
              top: _controller.value * size.height,
              height: size.height,
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.cover,
              ),
            ),
            // Tấm ảnh thứ hai chạy nối đuôi ngay bên trên
            Positioned(
              left: 0,
              right: 0,
              top: (_controller.value - 1) * size.height,
              height: size.height,
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.cover,
              ),
            ),
            // Giao diện chính (Các xe cộ, cột, nút bấm...)
            widget.child,
          ],
        );
      },
    );
  }
}
