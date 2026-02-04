import 'package:blueberry/view/orders/controller/order_controller.dart';
import 'package:blueberry/view/orders/model/order_response_new.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';

part 'new_order_detail_store.g.dart';

class NewOrderDetailStore = _NewOrderDetailStore with _$NewOrderDetailStore;

abstract class _NewOrderDetailStore with Store {
  @observable
  bool isLoading = false;

  @observable
  OrderData? order;

  @observable
  ObservableMap<int, bool> selectedItems = ObservableMap<int, bool>();

  @observable
  ObservableMap<int, TextEditingController> dispatchQtyControllers = ObservableMap<int, TextEditingController>();

  @action
  Future<void> fetchOrderDetail(int orderId) async {
    OrderController.orderDetailNew(orderID: orderId);
    isLoading = true;
    try {
      final response = await OrderController.orderDetailNew(orderID: orderId);
      order = response;

      // Initialize selections and controllers
      selectedItems.clear();
      dispatchQtyControllers.clear();

      order?.orderItems?.forEach((item) {
        if (item.id != null) {
          final isDispatched = item.status == "Dispatched";
          selectedItems[item.id!] = !isDispatched;
          final remaining = (item.quantity ?? 0) - (item.dispatchedQuantity ?? 0);
          dispatchQtyControllers[item.id!] = TextEditingController(text: remaining.toString());
        }
      });
    } catch (e) {
      log("Error fetching order detail: $e");
    } finally {
      isLoading = false;
    }
  }

  @action
  void toggleSelection(int itemId, bool? value) {
    selectedItems[itemId] = value ?? false;
  }

  @action
  void toggleSelectAll(bool? value) {
    order?.orderItems?.forEach((item) {
      if (item.id != null && item.status != "Dispatched") {
        selectedItems[item.id!] = value ?? false;
      }
    });
  }

  @computed
  bool get isAllSelected {
    final eligibleItems = order?.orderItems?.where((item) => item.status != "Dispatched").toList() ?? [];
    if (eligibleItems.isEmpty) return false;
    return eligibleItems.every((item) => selectedItems[item.id] ?? false);
  }

  @action
  Future<void> updateStatus() async {
    if (order == null) return;

    final selectedIds = selectedItems.entries.where((e) => e.value).map((e) => e.key).toList();

    if (selectedIds.isEmpty) {
      toast("Please select at least one item");
      return;
    }

    isLoading = true;

    // Constructing specific payload
    final List<int> orderItemIds = [];
    final Map<String, int> quantities = {};
    bool isAllItemsDispatchedFully = true;

    // Check if ALL order items are selected AND have their full remaining quantity entered
    final allItemIds = order!.orderItems!.map((e) => e.id).toList();
    if (selectedIds.length != allItemIds.length) {
      isAllItemsDispatchedFully = false;
    }

    for (var item in order!.orderItems!) {
      final id = item.id!;
      final isSelected = selectedItems[id] ?? false;
      final enteringQty = dispatchQtyControllers[id]?.text.toInt() ?? 0;
      final remainingQty = (item.quantity ?? 0) - (item.dispatchedQuantity ?? 0);

      if (isSelected) {
        orderItemIds.add(id);
        quantities[id.toString()] = enteringQty;
        if (enteringQty < remainingQty) {
          isAllItemsDispatchedFully = false;
        }
      } else {
        // If an item is not selected but still has remaining quantity, it's not a full dispatch
        if (remainingQty > 0) {
          isAllItemsDispatchedFully = false;
        }
      }
    }

    final String status = isAllItemsDispatchedFully ? "Dispatched" : "Partial Dispatched";

    final payload = {
      "order_id": order!.id,
      "order_item_ids": orderItemIds,
      "status": status,
      "quantities": quantities,
    };

    try {
      final res = await OrderController.updateOrderStatusApi(request: payload);
      toast(res.message.validate());
      fetchOrderDetail(order!.id!); // Refresh data
    } catch (e) {
      log("Error updating status: $e");
      toast(e.toString());
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> revertStatus(int statusId, int orderItemId) async {
    isLoading = true;
    try {
      final res = await OrderController.revertOrderStatusApi(orderStatusId: statusId, orderItemId: orderItemId);
      toast(res.message.validate());
      await fetchOrderDetail(order!.id!); // Refresh data
    } catch (e) {
      log("Error reverting status: $e");
      toast(e.toString());
    } finally {
      isLoading = false;
    }
  }

  void dispose() {
    dispatchQtyControllers.values.forEach((c) => c.dispose());
  }
}
