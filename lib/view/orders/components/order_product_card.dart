import 'package:blueberry/utils/functions.dart';
import 'package:blueberry/view/orders/model/order_response_new.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class OrderProductCard extends StatelessWidget {
  final OrderItems item;
  final bool isSelected;
  final Function(bool?) onSelected;
  final TextEditingController dispatchController;
  final bool isReadOnly;

  const OrderProductCard({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onSelected,
    required this.dispatchController,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final remaining = (item.quantity ?? 0) - (item.dispatchedQuantity ?? 0);

    return Opacity(
      opacity: item.status == "Dispatched" ? 0.5 : 1.0,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: radius(8),
          border: Border.all(color: isSelected ? context.primaryColor : context.dividerColor, width: 1),
          boxShadow: defaultBoxShadow(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isReadOnly && item.status != "Dispatched") Checkbox(value: isSelected, onChanged: onSelected, activeColor: context.primaryColor).withHeight(24).withWidth(24),
                if (!isReadOnly && item.status != "Dispatched") 8.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.product?.name ?? 'Unknown Product', style: boldTextStyle(size: 14)),
                      if (item.marking.validate().isNotEmpty) Text("Marking: ${item.marking}", style: secondaryTextStyle(color: Colors.orange, size: 12)),
                      if (item.packaging.validate().isNotEmpty) Text("Pkg: ${item.packaging!.join(', ')}", style: secondaryTextStyle(size: 12)),
                    ],
                  ),
                ),
                8.width,
                SizedBox(
                  width: 70,
                  child: AppTextField(
                    readOnly: isReadOnly || !isSelected,
                    controller: dispatchController,
                    textFieldType: TextFieldType.NUMBER,
                    textAlign: TextAlign.center,
                    decoration: inputDecoration(hint: "Qty").copyWith(contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4)),
                  ),
                ),
              ],
            ),
            4.height,
            const Divider(),
            4.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoColumn("Total", item.quantity.toString()),
                _infoColumn("Disp", item.dispatchedQuantity.toString()),
                _infoColumn("Rem", remaining.toString(), color: remaining > 0 ? Colors.red : Colors.green),
                _infoColumn("Status", item.status.validate(), color: _getStatusColor(item.status)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case "Pending":
        return Colors.red;
      case "Partial Dispatched":
        return Colors.orange;
      case "Dispatched":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Widget _infoColumn(String label, String value, {Color? color}) {
    return Column(
      children: [
        Text(label, style: secondaryTextStyle(size: 10)),
        Text(value, style: boldTextStyle(size: 12, color: color)),
      ],
    );
  }
}
