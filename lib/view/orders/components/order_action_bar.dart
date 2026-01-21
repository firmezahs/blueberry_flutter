import 'package:blueberry/view/orders/widget/order_status_chip_widget.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class OrderActionBar extends StatelessWidget {
  final String status;
  final VoidCallback onChangeStatus;

  const OrderActionBar({super.key, required this.status, required this.onChangeStatus});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(.08), blurRadius: 10)],
        ),
        child: Row(
          children: [
            OrderStatusChip(status: status.validate()),
            const Spacer(),
            ElevatedButton(
              onPressed: onChangeStatus,
              child: Text("Submit Order", style: boldTextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
