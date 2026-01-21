import 'package:blueberry/view/orders/model/order_response.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomerInfoCard extends StatelessWidget {
  final OrderData order;

  const CustomerInfoCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Customer', style: secondaryTextStyle(size: 14)),
        const SizedBox(height: 6),
        Text(order.customerName.validate(), style: boldTextStyle()),
        16.height,
      ],
    );
  }
}
