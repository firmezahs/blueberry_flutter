import 'package:blueberry/main.dart';
import 'package:blueberry/utils/colors.dart';
import 'package:blueberry/view/orders/model/order_response.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class OrderItemsList extends StatelessWidget {
  final List<OrderItems> items;

  final Function onUpdate;

  const OrderItemsList({super.key, required this.items, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.height,
        Text('Products (${items.length})', style: boldTextStyle()),
        const SizedBox(height: 12),
        ...items.map((e) {
          return GestureDetector(
            onTap: () {
              if (e.status == "Dispatched") return;

              orderDetailStore.toggleItemUpdate(e.id!, !e.isUpdate.validate());
              onUpdate.call();
            },
            child: Opacity(
              opacity: e.status == "Dispatched" ? 0.7 : 1,
              child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(top: 4, bottom: 4),
                decoration: BoxDecoration(color: context.cardColor, borderRadius: radius(), boxShadow: defaultBoxShadow()),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        mainAxisSize: .min,
                        children: [
                          Text('${e.quantity.validate()}', style: boldTextStyle()),
                          Text('Qty', style: secondaryTextStyle()),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (e.product != null) ...{Text(e.product?.name.validate() ?? '', style: boldTextStyle(size: 18))},
                          if (e.marking.validate().isNotEmpty) ...{4.height, Text('${e.marking}', style: primaryTextStyle(color: Colors.orange.shade700))},

                          if (e.packaging.validate().isNotEmpty) ...{
                            4.height,
                            Wrap(
                              spacing: 4,
                              runSpacing: 4,
                              children: e.packaging
                                  .validate()
                                  .map(
                                    (e) => Container(
                                      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: radius()),
                                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      child: Text(e, style: secondaryTextStyle(color: primaryColor, size: 12)),
                                    ),
                                  )
                                  .toList(),
                            ),
                            4.height,
                          },
                        ],
                      ),
                    ),
                    16.width,
                    Checkbox(
                      value: e.isUpdate,
                      activeColor: e.status == "Dispatched" ? Colors.green : primaryColor,
                      onChanged: (value) {
                        if (e.status == "Dispatched") return;
                        orderDetailStore.toggleItemUpdate(e.id!, value ?? false);
                        onUpdate.call();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
