import 'package:flutter/material.dart';

class UrgentOrderBanner extends StatelessWidget {
  final String title;
  final String subtitle;

  const UrgentOrderBanner({super.key, this.title = 'Urgent Order', this.subtitle = 'Expedited handling required'});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1F1), // soft red background
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFFECACA), // light red border
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon container
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: const Color(0xFFFEE2E2), borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.priority_high, size: 18, color: Color(0xFFDC2626)),
          ),

          const SizedBox(width: 12),

          // Texts
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFFB91C1C)),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF991B1B))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
