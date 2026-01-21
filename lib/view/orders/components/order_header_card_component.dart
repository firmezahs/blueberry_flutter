import 'package:blueberry/network/api_client.dart';
import 'package:blueberry/view/orders/model/order_response.dart';
import 'package:blueberry/view/orders/widget/urgent_order_banner_widget.dart';
import 'package:flutter/material.dart';

class OrderHeaderCard extends StatelessWidget {
  final OrderData order;

  const OrderHeaderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (order.isUrgent == true) ...[const SizedBox(width: 8), UrgentOrderBanner(subtitle: 'Priority delivery requested by customer'),16.height,],
      ],
    );
  }
}
