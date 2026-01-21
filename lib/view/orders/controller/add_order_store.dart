import 'package:blueberry/main.dart';
import 'package:blueberry/view/orders/controller/order_controller.dart';
import 'package:blueberry/view/orders/model/order_response.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';

part 'add_order_store.g.dart';

class AddOrderStore = _AddOrderStore with _$AddOrderStore;

abstract class _AddOrderStore with Store {
  _AddOrderStore() {
    initPackagingOptions(appStore.packagingOrder!.data!.validate());
  }
  // Controllers
  TextEditingController customerNameCont = TextEditingController();
  TextEditingController notesCont = TextEditingController();

  // Controllers
  TextEditingController productNameCont = TextEditingController();
  TextEditingController quantityCont = TextEditingController();
  TextEditingController markingCont = TextEditingController();

  // ---------------- Packaging ----------------

  /// All packaging options from API
  @observable
  ObservableMap<String, bool> packagingSelections = ObservableMap();

  @action
  void initPackagingOptions(List<String> options) {
    packagingSelections.clear();
    for (final opt in options) {
      packagingSelections[opt] = false;
    }
  }

  @action
  void togglePackaging(String key, bool value) {
    packagingSelections[key] = value;
  }

  bool get hasAnyPackagingSelected => packagingSelections.values.any((v) => v == true);

  @observable
  bool isUrgent = false;

  @observable
  ObservableList<OrderItems> products = ObservableList<OrderItems>();

  @observable
  bool isLoading = false;

  // Actions
  @action
  void toggleUrgent(bool v) => isUrgent = v;

  @action
  void addProduct() {
    isLoading = true;
    final productPayload = {
      "product": {'name': productNameCont.text, 'description': ""},
      "quantity": int.tryParse(quantityCont.text) ?? 1,
      "marking": markingCont.text,
      "packaging": packagingSelections.entries.where((e) => e.value).map((e) => e.key).toList(),
    };

    products.add(OrderItems.fromJson(productPayload));
    productDispose();
    isLoading = false;
  }

  @action
  void editProduct(int index) {
    isLoading = true;
    final productPayload = {
      "product": {'name': productNameCont.text, 'description': ""},
      "quantity": int.tryParse(quantityCont.text) ?? 1,
      "marking": markingCont.text,
      "packaging": packagingSelections.entries.where((e) => e.value).map((e) => e.key).toList(),
    };

    products[index] = OrderItems.fromJson(productPayload);
    productDispose();
    isLoading = false;
  }

  @action
  void removeProduct(int index) {
    products.removeAt(index);
  }

  @action
  Future<void> submitOrder() async {
    isLoading = true;

    final payload = {
      "customer_name": customerNameCont.text.trim(),
      "employee_id": userStore.employeeData!.id.validate(),
      "is_urgent": isUrgent,
      "products": products.map((element) => element.toSaveJson()).toList(),
      "note": notesCont.text.trim(),
    };

    debugPrint(payload.toString());

    OrderController.saveOrderApi(request: payload)
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

  @action
  Future<void> editOrder({required int orderId}) async {
    isLoading = true;

    final payload = {
      "customer_name": customerNameCont.text.trim(),
      "employee_id": userStore.employeeData!.id.validate(),
      "is_urgent": isUrgent,
      "products": products.map((element) => element.toSaveJson()).toList(),
      "note": notesCont.text.trim(),
    };

    debugPrint(payload.toString());

    OrderController.updateOrderApi(request: payload, id: orderId)
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

  void dispose() {
    customerNameCont.dispose();
    notesCont.dispose();
    productNameCont.dispose();
    quantityCont.dispose();
    markingCont.dispose();
  }

  void productDispose() {
    productNameCont.clear();
    quantityCont.clear();
    markingCont.clear();
    initPackagingOptions(appStore.packagingOrder!.data!.validate());
  }
}
