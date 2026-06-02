import 'package:flutter/material.dart';

class FinishLine extends StatelessWidget {
  final double bottomPosition;

  const FinishLine({
    super.key,
    required this.bottomPosition,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: bottomPosition,
      height: 20,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: List.generate(24, (i) => Expanded(
                child: Container(color: i % 2 == 0 ? Colors.white : Colors.black),
              )),
            ),
          ),
          Expanded(
            child: Row(
              children: List.generate(24, (i) => Expanded(
                child: Container(color: i % 2 == 0 ? Colors.black : Colors.white),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
