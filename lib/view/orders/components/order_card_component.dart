import 'package:blueberry/view/orders/model/order_response.dart';
import 'package:blueberry/view/orders/new_order_detail_screen.dart';
import 'package:blueberry/view/orders/widget/order_status_chip_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

class OrderCardComponent extends StatelessWidget {
  final OrderData order;
  final EdgeInsetsGeometry? margin;

  const OrderCardComponent({super.key, required this.order, this.margin});

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(order.orderStatus.validate());

    return GestureDetector(
      onTap: () {
        NewOrderDetailScreen(orderId: order.id.validate()).launch(context);
      },
      child: Container(
        margin: margin ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        clipBehavior: Clip.antiAlias,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Vertical Status Strip
              Container(width: 4, color: statusColor),

              // Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OrderStatusChip(status: order.orderStatus.validate()),
                          Text('#${order.orderNumber}', style: secondaryTextStyle(size: 13, weight: FontWeight.bold)),
                        ],
                      ),
                      8.height,

                      // Customer Name Row
                      Row(
                        children: [
                          Expanded(
                            child: Text(order.customerName.validate(), style: boldTextStyle(size: 16), maxLines: 1, overflow: TextOverflow.ellipsis),
                          ),
                          Icon(Icons.chevron_right, color: context.dividerColor, size: 18),
                        ],
                      ),
                      8.height,

                      // Footer Row
                      Row(
                        children: [
                          Icon(Icons.inventory_2_outlined, size: 12, color: context.iconColor),
                          4.width,
                          Text('${order.orderItemsCount.validate()} Items', style: secondaryTextStyle(size: 11)),
                          const Spacer(),
                          if (order.isUrgent == true)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(6)),
                              child: Row(
                                children: [
                                  Icon(Icons.flash_on, size: 10, color: Colors.red.shade700),
                                  2.width,
                                  Text("URGENT", style: boldTextStyle(size: 9, color: Colors.red.shade700)),
                                ],
                              ),
                            ).paddingRight(6),
                          Text(DateFormat('MMM dd, HH:mm').format(DateTime.parse(order.createdAt.validate())), style: secondaryTextStyle(size: 10)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return const Color(0xFFD97706); // Amber
      case 'Partial Dispatched':
        return const Color(0xFF0369A1); // Blue
      case 'Dispatched':
        return const Color(0xFF7E22CE); // Purple
      case 'Delivered':
        return const Color(0xFF15803D); // Green
      case 'Rejected':
        return const Color(0xFFB91C1C); // Red
      default:
        return Colors.grey;
    }
  }
}
