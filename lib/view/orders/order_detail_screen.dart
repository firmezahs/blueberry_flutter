import 'package:blueberry/main.dart';
import 'package:blueberry/view/orders/add_order_view.dart';
import 'package:blueberry/view/orders/components/customer_info_card.dart';
import 'package:blueberry/view/orders/components/order_action_bar.dart';
import 'package:blueberry/view/orders/components/order_header_card_component.dart';
import 'package:blueberry/view/orders/components/order_items_list.dart';
import 'package:blueberry/view/orders/components/order_notes_card.dart';
import 'package:blueberry/view/orders/controller/add_order_store.dart';
import 'package:blueberry/view/orders/widget/change_order_status_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

class OrderDetailScreen extends StatefulWidget {
  final int orderId;

  const OrderDetailScreen({super.key, required this.orderId});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    orderDetailStore.fetchOrderDetail(widget.orderId);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Observer(
          builder: (context) {
            if (orderDetailStore.order != null) {
              return Column(
                children: [
                  Text('#${orderDetailStore.order!.orderNumber} ${orderDetailStore.order!.orderItems.validate().any((element) => element.isUpdate == false)}', style: boldTextStyle()),

                  Text(DateFormat('MMM dd, yyyy • hh:mm a').format(DateTime.parse(orderDetailStore.order!.createdAt.validate())), style: secondaryTextStyle()),
                ],
              );
            }
            return Text('Order Details', style: boldTextStyle());
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              addOrderStore = AddOrderStore();
              AddOrderScreen(order: orderDetailStore.order).launch(context);
            },
            visualDensity: VisualDensity.compact,
            style: ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
            icon: Icon(Icons.edit_outlined, color: context.primaryColor),
          ),
          IconButton(
            onPressed: () {
              showConfirmDialogCustom(context, onAccept: (context) {}, dialogType: DialogType.DELETE);
            },
            visualDensity: VisualDensity.compact,
            style: ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
            icon: Icon(Icons.delete_outline_outlined, color: context.theme.colorScheme.error),
          ),
        ],
        centerTitle: true,
      ),
      bottomNavigationBar: Observer(
        builder: (context) {
          if (orderDetailStore.order != null) {
            return OrderActionBar(
              status: orderDetailStore.order!.orderStatus.validate(),
              onChangeStatus: () async {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                  builder: (_) {
                    return ChangeOrderStatusSheet(
                      currentStatus: orderDetailStore.order!.orderItems.validate().any((element) => element.isUpdate == false && element.status != "Dispatched")
                          ? "partial"
                          : orderDetailStore.order!.orderStatus.validate(),
                      onSubmit: (newStatus) async {
                        Navigator.pop(context);

                        final ok = await confirmStatusChange(context, newStatus);
                        if (!ok) return;

                        if (newStatus == "Partial Dispatched") {
                          newStatus = "Dispatched";
                        }

                        await orderDetailStore.updateOrderStatus(orderId: orderDetailStore.order!.id.validate().toString(), status: newStatus);
                      },
                    );
                  },
                );
              },
            );
          }

          return Offstage();
        },
      ),
      body: Observer(
        builder: (_) {
          if (orderDetailStore.isLoading || orderDetailStore.order == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: const EdgeInsets.only(bottom: 100, top: 16, right: 16, left: 16),
            children: [
              OrderHeaderCard(order: orderDetailStore.order!),
              CustomerInfoCard(order: orderDetailStore.order!),
              OrderNotesCard(note: orderDetailStore.order!.note.validate()),
              Observer(
                builder: (context) {
                  return OrderItemsList(
                    items: orderDetailStore.order!.orderItems ?? [],
                    onUpdate: () {
                      setState(() {});
                    },
                  );
                },
              ),
              16.height,
            ],
          );
        },
      ),
    );
  }
}
