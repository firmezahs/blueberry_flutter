import 'package:blueberry/view/orders/model/order_response_new.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

class OrderStatusTrackingItem extends StatelessWidget {
  final OrderStatus status;
  final VoidCallback? onRevert;
  final bool isFirst;
  final bool isLast;

  const OrderStatusTrackingItem({super.key, required this.status, this.onRevert, this.isFirst = false, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline Indicator Column
          Column(
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: _getStatusColor(status.status).withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: _getStatusColor(status.status), width: 1.5),
                ),
                child: Center(child: Icon(_getStatusIcon(status.status), size: 10, color: _getStatusColor(status.status))),
              ),
              if (!isLast) Expanded(child: Container(width: 1.5, color: context.dividerColor.withOpacity(0.3))),
            ],
          ),
          8.width,

          // Content Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(status.status.validate(), style: boldTextStyle(size: 14, color: _getStatusColor(status.status))),
                    ),
                    Text(status.createdAt != null ? DateFormat('HH:mm').format(status.createdAt!) : '', style: secondaryTextStyle(size: 11)),
                  ],
                ),
                2.height,
                if (status.product != null) Text("Product: ${status.product!.name.validate()}", style: primaryTextStyle(size: 12)),
                if (status.dispatchQuantity.validate() > 0)
                  Text("Qty: ${status.dispatchQuantity}  •  By: ${status.addedBy?.fullName ?? 'System'}", style: secondaryTextStyle(size: 11))
                else
                  Text("By: ${status.addedBy?.fullName ?? 'System'}", style: secondaryTextStyle(size: 11)),
                if (onRevert != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 6, bottom: 8),
                    child: AppButton(
                      text: "Revert",
                      textStyle: boldTextStyle(color: Colors.red, size: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      onTap: onRevert,
                      shapeBorder: RoundedRectangleBorder(
                        borderRadius: radius(4),
                        side: const BorderSide(color: Colors.red, width: 0.5),
                      ),
                      color: Colors.white,
                      elevation: 0,
                    ),
                  )
                else
                  8.height,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? statusText) {
    switch (statusText?.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'partial dispatched':
        return Colors.blue;
      case 'dispatched':
        return Colors.green;
      case 'revert':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String? statusText) {
    switch (statusText?.toLowerCase()) {
      case 'pending':
        return Icons.shopping_bag_outlined;
      case 'partial dispatched':
        return Icons.local_shipping_outlined;
      case 'dispatched':
        return Icons.check_circle_outline;
      case 'revert':
        return Icons.history;
      default:
        return Icons.info_outline;
    }
  }
}

extension AddedByExt on AddedBy {
  String get fullName => "${firstName.validate()} ${lastName.validate()}".trim();
}
