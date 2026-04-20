import 'package:blueberry/main.dart';
import 'package:blueberry/view/common/components/custom_confirm_dialog.dart';
import 'package:blueberry/view/orders/components/order_product_card.dart';
import 'package:blueberry/view/orders/components/order_status_tracking_item.dart';
import 'package:blueberry/view/orders/controller/new_order_detail_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import 'model/order_response_new.dart';

class NewOrderDetailScreen extends StatefulWidget {
  final int orderId;

  const NewOrderDetailScreen({super.key, required this.orderId});

  @override
  State<NewOrderDetailScreen> createState() => _NewOrderDetailScreenState();
}

class _NewOrderDetailScreenState extends State<NewOrderDetailScreen> {
  final NewOrderDetailStore store = NewOrderDetailStore();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    store.fetchOrderDetail(widget.orderId);
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details', style: boldTextStyle()),
        centerTitle: true,
        actions: [IconButton(onPressed: () => store.fetchOrderDetail(widget.orderId), icon: const Icon(Icons.refresh))],
      ),
      body: Observer(
        builder: (_) {
          if (store.isLoading && store.order == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (store.order == null) {
            return const Center(child: Text("Order not found")).onTap(() => store.fetchOrderDetail(widget.orderId));
          }

          final OrderData order = store.order!;
          return AnimatedScrollView(
            padding: const EdgeInsets.all(16),
            children: [
              // Order Summary Header
              _buildHeader(order),
              24.height,

              // Products Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Products (${order.orderItems?.length ?? 0})", style: boldTextStyle(size: 18)),
                  if (order.orderItems.validate().any((item) => item.status != "Dispatched"))
                    Row(
                      children: [
                        Text("Select All", style: secondaryTextStyle()),
                        Checkbox(value: store.isAllSelected, onChanged: store.toggleSelectAll, activeColor: context.primaryColor),
                      ],
                    ),
                ],
              ),
              8.height,
              ...order.orderItems!.map((item) {
                return OrderProductCard(
                  item: item,
                  isSelected: store.selectedItems[item.id] ?? false,
                  onSelected: (val) => store.toggleSelection(item.id!, val),
                  dispatchController: store.dispatchQtyControllers[item.id]!,
                  isReadOnly: order.orderStatus.validate().isNotEmpty && order.orderStatus!.last.status == "Dispatched",
                );
              }).toList(),

              // Action Buttons
              if (order.orderStatus.validate().isEmpty || order.orderStatus!.last.status != "Dispatched") ...[
                16.height,
                AppButton(
                  text: "Submit Order",
                  width: context.width(),
                  color: context.primaryColor,
                  textStyle: boldTextStyle(color: Colors.white),
                  onTap: () {
                    showCustomConfirmDialog(context, title: "Submit Order?", subTitle: "This will update the order status based on your selections.", onAccept: () => store.updateStatus());
                  },
                ),
              ],

              // Notes Section
              if (order.note.validate().isNotEmpty) ...[
                24.height,
                Text("Note", style: boldTextStyle(size: 18)),
                8.height,
                Container(
                  width: context.width(),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.primaryColor.withOpacity(0.05),
                    borderRadius: radius(8),
                    border: Border.all(color: context.primaryColor.withOpacity(0.1)),
                  ),
                  child: ReadMoreText(order.note!, style: primaryTextStyle()),
                ),
              ],

              // Order Status History
              24.height,
              Text("Order Status History", style: boldTextStyle(size: 18)),
              8.height,
              if (order.orderStatus.validate().isEmpty)
                Text("No status history available", style: secondaryTextStyle()).paddingAll(16)
              else
                ...(() {
                  final statusList = order.orderStatus.validate().reversed.toList();
                  return statusList.asMap().entries.map((entry) {
                    final index = entry.key;
                    final status = entry.value;

                    // Original index in the non-reversed list
                    final originalStatusList = order.orderStatus.validate();
                    final originalIndex = originalStatusList.indexOf(status);
                    final previousStatus = originalIndex > 0 ? originalStatusList[originalIndex - 1].status : "N/A";

                    return OrderStatusTrackingItem(
                      status: status,
                      isFirst: index == 0,
                      isLast: index == statusList.length - 1,
                      onRevert: (userStore.isAdmin && status.status != "Pending" && status.status != "Revert")
                          ? () {
                              String subDescription = "Reverting from '${status.status}' back to '$previousStatus'.";

                              if (status.dispatchQuantity.validate() > 0 && status.orderItemId != null) {
                                final item = order.orderItems?.firstWhere((e) => e.id == status.orderItemId, orElse: () => OrderItems());
                                if (item != null && item.id != null) {
                                  final currentDisp = item.dispatchedQuantity ?? 0;
                                  final afterRevert = currentDisp - status.dispatchQuantity.validate();
                                  subDescription += "\n\nQty Change: $currentDisp ====> $afterRevert";
                                }
                              }

                              showCustomConfirmDialog(
                                context,
                                title: "Revert Status?",
                                subTitle: "$subDescription\n\nAre you sure?",
                                positiveText: "Yes, Revert",
                                positiveColor: Colors.red,
                                onAccept: () => store.revertStatus(status.id!, status.orderItemId ?? 0),
                              );
                            }
                          : null,
                    );
                  });
                })().toList(),

              100.height, // Space for bottom button
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(OrderData order) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: context.cardColor, borderRadius: radius(12), boxShadow: defaultBoxShadow()),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Order Number:", style: secondaryTextStyle()),
              Row(
                children: [
                  if (order.isUrgent == true)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Icon(Icons.flash_on, size: 12, color: Colors.red.shade700),
                          4.width,
                          Text("URGENT", style: boldTextStyle(size: 10, color: Colors.red.shade700)),
                        ],
                      ),
                    ).paddingRight(8),
                  Text(order.orderNumber ?? 'N/A', style: boldTextStyle()),
                ],
              ),
            ],
          ),
          8.height,
          // if (order.orderStatus != null) ...[_headerRowWidget("Status:", OrderStatusChip(status: order.orderStatus!.last.status.validate())), 8.height],
          _headerRow("Customer Name:", order.customerName ?? 'N/A'),
          8.height,
          _headerRow("Ordered At:", order.createdAt != null ? DateFormat('MMM dd, yyyy HH:mm').format(order.createdAt!) : 'N/A'),
        ],
      ),
    );
  }

  Widget _headerRowWidget(String label, Widget child) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: secondaryTextStyle()),
        child,
      ],
    );
  }

  Widget _headerRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: secondaryTextStyle()),
        Text(value, style: boldTextStyle()),
      ],
    );
  }
}
