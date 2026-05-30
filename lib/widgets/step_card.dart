import 'package:flutter/material.dart';

class StepCard extends StatelessWidget {
  final String step;
  final String title;
  final String description;
  final Color color;
  final IconData icon;

  const StepCard({
    super.key,
    required this.step,
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xff3B1F1F), width: 1.5),
      ),
      child: Column(
        children: [
          /// ICON BOX
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xffC51D1D), size: 30),
          ),
          const SizedBox(height: 10),

          /// STEP TEXT
          Text(
            step,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xff5B3B3B),
            ),
          ),

          const SizedBox(height: 6),

          /// TITLE
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xff3B1F1F),
            ),
          ),

          const SizedBox(height: 8),

          /// DESCRIPTION
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xff5B3B3B),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
