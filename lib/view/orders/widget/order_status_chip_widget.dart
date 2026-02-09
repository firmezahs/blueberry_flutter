import 'package:flutter/material.dart';

class OrderStatusChip extends StatelessWidget {
  final String status;

  const OrderStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final config = _statusConfig(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: config.bgColor, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(config.icon, size: 12, color: config.textColor),
          const SizedBox(width: 4),
          Text(
            status,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: config.textColor),
          ),
        ],
      ),
    );
  }

  StatusConfig _statusConfig(String status) {
    switch (status) {
      case 'Partial Dispatched':
        return StatusConfig(
          icon: Icons.pending_actions_rounded,
          bgColor: const Color(0xFFE0F2FE),
          textColor: const Color(0xFF0369A1),
        );

      case 'Dispatched':
        return StatusConfig(
          icon: Icons.local_shipping_rounded,
          bgColor: const Color(0xFFF3E8FF),
          textColor: const Color(0xFF7E22CE),
        );

      case 'Delivered':
        return StatusConfig(
          icon: Icons.check_circle_rounded,
          bgColor: const Color(0xFFDCFCE7),
          textColor: const Color(0xFF15803D),
        );

      case 'Rejected':
        return StatusConfig(
          icon: Icons.cancel_rounded,
          bgColor: const Color(0xFFFEE2E2),
          textColor: const Color(0xFFB91C1C),
        );

      case 'Pending':
      default:
        return StatusConfig(
          icon: Icons.hourglass_empty_rounded,
          bgColor: const Color(0xFFFEF3C7),
          textColor: const Color(0xFFD97706),
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
