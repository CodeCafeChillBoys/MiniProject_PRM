import 'package:flutter/material.dart';

Widget buildHeader({VoidCallback? onClosePressed}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),

    child: Row(
      children: [
        /// LOGO
        const Icon(Icons.sports_motorsports, color: Colors.red),

        const SizedBox(width: 6),

        const Text(
          "PRO RACER",
          style: TextStyle(
            color: Colors.red,
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),

        const Spacer(),

        /// MONEY BOX
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

          decoration: BoxDecoration(
            color: const Color(0xffEBCB72),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.brown, width: 2),
          ),

          child: const Row(
            children: [
              Icon(Icons.attach_money, size: 18),
              Text("2,500", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          tooltip: 'Close',
          onPressed: onClosePressed,
          icon: const Icon(Icons.close),
        ),
      ],
    ),
  );
}
