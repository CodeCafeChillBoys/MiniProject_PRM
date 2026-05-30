import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final int totalMoney;

  const TopBar({super.key, required this.totalMoney});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).padding.top + 60,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 16,
        right: 16,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // LOGO & PRO RACER
          Row(
            children: const [
              Icon(Icons.sports_motorsports, color: Color(0xFFC62828), size: 28),
              SizedBox(width: 6),
              Text(
                'PRO RACER',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFFC62828),
                ),
              ),
            ],
          ),
          // TOTAL MONEY PİLL
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFFD54F), // Nền vàng
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black87, width: 2),
            ),
            child: Row(
              children: [
                Icon(Icons.payments, size: 18, color: Colors.green[800]),
                const SizedBox(width: 4),
                Text(
                  '\$$totalMoney',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
