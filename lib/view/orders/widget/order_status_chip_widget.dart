import 'package:flutter/material.dart';

class OrderStatusChip extends StatelessWidget {
  final String status;

  const OrderStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final config = _statusConfig(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: config.bgColor, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(config.icon, size: 14, color: config.textColor),
          const SizedBox(width: 6),
          Text(
            status,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: config.textColor),
          ),
        ],
      ),
    );
  }

  StatusConfig _statusConfig(String status) {
    switch (status) {
      case 'Partial Dispatched':
        return StatusConfig(
          icon: Icons.check_circle,
          bgColor: const Color(0xFFEFF6FF), // blue-50
          textColor: const Color(0xFF2563EB), // blue-600
        );

      case 'Dispatched':
        return StatusConfig(
          icon: Icons.local_shipping_rounded,
          bgColor: const Color(0xFFF3E8FF), // purple-50
          textColor: const Color(0xFF7C3AED), // purple-600
        );

      case 'Delivered':
        return StatusConfig(
          icon: Icons.inventory_2_rounded,
          bgColor: const Color(0xFFECFDF5), // green-50
          textColor: const Color(0xFF059669), // green-600
        );

      case 'Rejected':
        return StatusConfig(
          icon: Icons.cancel_rounded,
          bgColor: const Color(0xFFFEF2F2), // red-50
          textColor: const Color(0xFFDC2626), // red-600
        );

      case 'Pending':
      default:
        return StatusConfig(
          icon: Icons.hourglass_top_rounded,
          bgColor: const Color(0xFFFFFBEB), // amber-50
          textColor: const Color(0xFFB45309), // amber-700
        );
    }
  }
}

class StatusConfig {
  final IconData icon;
  final Color bgColor;
  final Color textColor;

  StatusConfig({required this.icon, required this.bgColor, required this.textColor});
}
