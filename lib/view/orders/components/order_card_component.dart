import 'package:blueberry/utils/functions.dart';
import 'package:blueberry/view/orders/model/order_response.dart';
import 'package:blueberry/view/orders/new_order_detail_screen.dart';
import 'package:blueberry/view/orders/widget/order_status_chip_widget.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class OrderCardComponent extends StatelessWidget {
  final OrderData order;

  final EdgeInsetsGeometry? margin;

  const OrderCardComponent({super.key, required this.order, this.margin});

  int get productCount => order.orderItems?.length ?? 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NewOrderDetailScreen(orderId: order.id.validate()).launch(context);
      },
      child: Container(
        margin: margin ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: order.isUrgent == true ? Colors.red.shade200 : Colors.grey.shade200, width: 0.6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------- Header ----------------
            Row(
              children: [
                Text('#${order.orderNumber}', style: boldTextStyle(size: 18, color: context.primaryColor)).expand(),
                OrderStatusChip(status: order.orderStatus.validate()),
              ],
            ),

            const SizedBox(height: 2),

            // ---------------- Customer ----------------
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Text(order.customerName.validate(), style: boldTextStyle(size: 20)).expand(),
                16.width,
                Text('${order.orderItemsCount.validate()} product${order.orderItemsCount.validate() == 1 ? '' : 's'}', style: primaryTextStyle(size: 14), overflow: TextOverflow.ellipsis),
              ],
            ),

            const SizedBox(height: 04),

            Row(
              crossAxisAlignment: .end,
              mainAxisAlignment: .end,
              children: [
                if (order.isUrgent == true) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(color: Color(0xFFFEE2E2), borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.priority_high, size: 14, color: Color(0xFFDC2626)),
                        const SizedBox(width: 2),
                        Text("Urgent", style: boldTextStyle(color: Color(0xFFB91C1C), size: 12)),
                      ],
                    ),
                  ),
                  Spacer(),
                ],
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (order.orderStatus == "Dispatched") ...{Text("Completed By ${order.employee?.firstName}", style: primaryTextStyle(size: 14, color: Colors.orangeAccent)), 2.height},
                    Text(
                      getCreatedOrEditedLabel(createdAt: order.createdAt.validate(), updatedAt: order.updatedAt.validate()),
                      style: secondaryTextStyle(size: 10),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
