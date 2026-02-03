import 'package:blueberry/view/orders/model/order_response_new.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

class OrderStatusTrackingItem extends StatelessWidget {
  final OrderStatus status;
  final VoidCallback? onRevert;

  const OrderStatusTrackingItem({super.key, required this.status, this.onRevert});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: radius(8),
        border: Border.all(color: context.dividerColor.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _StatusBadge(status: status.status ?? 'Pending'),
              if (onRevert != null && status.status != 'Pending')
                AppButton(
                  text: "Revert",
                  textStyle: boldTextStyle(color: Colors.red, size: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  onTap: onRevert,
                  shapeBorder: RoundedRectangleBorder(
                    borderRadius: radius(4),
                    side: const BorderSide(color: Colors.red, width: 0.5),
                  ),
                  color: Colors.white,
                  elevation: 0,
                ),
            ],
          ),
          8.height,
          if (status.product != null) Text("Product: ${status.product!.name.validate()}", style: primaryTextStyle(size: 14)),
          if (status.dispatchQuantity != null && status.dispatchQuantity != "0") Text("Dispatch Qty: ${status.dispatchQuantity}", style: primaryTextStyle(size: 14)),
          8.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("By: ${status.addedBy?.fullName ?? 'System'}", style: secondaryTextStyle(size: 12)),
              Text(status.createdAt != null ? DateFormat('MMM dd, yyyy HH:mm').format(status.createdAt!) : '', style: secondaryTextStyle(size: 11)),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.grey.shade100;
    Color textColor = Colors.grey.shade700;

    switch (status.toLowerCase()) {
      case 'pending':
        bgColor = Colors.orange.shade50;
        textColor = Colors.orange.shade700;
        break;
      case 'partial dispatched':
      case 'dispatched':
        bgColor = Colors.blue.shade50;
        textColor = Colors.blue.shade700;
        break;
      case 'delivered':
        bgColor = Colors.green.shade50;
        textColor = Colors.green.shade700;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bgColor, borderRadius: radius(4)),
      child: Text(status, style: boldTextStyle(size: 10, color: textColor)),
    );
  }
}

extension AddedByExt on AddedBy {
  String get fullName => "${firstName.validate()} ${lastName.validate()}".trim();
}
