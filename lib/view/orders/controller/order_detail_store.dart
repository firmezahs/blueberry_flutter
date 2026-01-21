import 'package:blueberry/main.dart';
import 'package:blueberry/view/orders/controller/order_controller.dart';
import 'package:blueberry/view/orders/model/order_response.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';

part 'order_detail_store.g.dart';

class OrderDetailStore = _OrderDetailStore with _$OrderDetailStore;

abstract class _OrderDetailStore with Store {
  @observable
  bool isLoading = false;

  @observable
  OrderData? order;

  @action
  Future<void> fetchOrderDetail(int orderId) async {
    isLoading = true;
    try {
      order = await OrderController.orderDetail(orderID: orderId);
    } finally {
      isLoading = false;
    }
  }

  @action
  void toggleItemUpdate(int itemId, bool value) {
    if (order == null) return;

    final item = order!.orderItems!.firstWhere((e) => e.id == itemId);

    item.isUpdate = value;

    // 🔥 THIS IS THE KEY LINE
    order = order;
  }

  @action
  void toggleAll(bool value) {
    order?.orderItems?.forEach((e) => e.isUpdate = value);
    order = order;
  }

  // @action
  // bool get hasPartialUpdate {
  //   if (order == null || order!.orderItems.validate().isEmpty) return false;
  //
  //   final items = order!.orderItems!;
  //   log(items);
  //   return items.any((e) => e.isUpdate.validate()) && items.any((e) => !e.isUpdate.validate());
  // }

  @action
  Future<void> updateOrderStatus({required String orderId, String? status}) async {
    isLoading = true;

    var list = orderDetailStore.order!.orderItems.validate().where(((element) => element.isUpdate == true)).map((e) => e.id.validate()).toList();

    final payload = {"order_id": orderId, "status": status ?? "Dispatched", "order_item_ids": list};

    debugPrint(payload.toString());

    OrderController.updateOrderStatusApi(request: payload)
        .then((value) {
          toast(value.message.validate());
          finish(getContext);
        })
        .catchError((e) {
          log(e.toString());
        })
        .whenComplete(() {
          isLoading = false;
        });
  }
}
