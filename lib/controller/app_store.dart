import 'dart:convert';

import 'package:blueberry/main.dart';
import 'package:blueberry/utils/config.dart';
import 'package:blueberry/utils/constant.dart';
import 'package:blueberry/utils/locale/base_language.dart';
import 'package:blueberry/view/orders/controller/order_controller.dart';
import 'package:blueberry/view/orders/model/packaging_response.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';

part 'app_store.g.dart';

class AppStore = AppStoreBase with _$AppStore;

abstract class AppStoreBase with Store {
  @observable
  String? fcmToken;

  @observable
  PackagingResponse? packagingOrder;
  @observable
  OrderStatus? orderStatus;

  @action
  Future<void> init() async {
    OrderController.productPackingApi()
        .then((value) {
          setPackagingOrder(value);
        })
        .catchError((e) {
          log("Error in Packaging ${e.toString()}");
        });
    OrderController.orderStatus()
        .then((value) {
          setOrderStatus(value);
        })
        .catchError((e) {
          log("Error in Packaging ${e.toString()}");
        });
  }

  @action
  Future<void> loadPackagingData() async {
    try {
      final jsonString = await getJSONAsync(SharePreferencesKey.packagingData);
      if (jsonString.isNotEmpty) {
        final Map<String, dynamic> json = jsonString;
        packagingOrder = PackagingResponse.fromJson(json);
      }
    } catch (e) {
      debugPrint("Error loading packaging data: $e");
    }
  }

  @action
  Future<void> loadOrderStatusData() async {
    try {
      final jsonString = await getJSONAsync(SharePreferencesKey.orderStatus);
      if (jsonString.isNotEmpty) {
        final Map<String, dynamic> json = jsonString;
        orderStatus = OrderStatus.fromJson(json);
      }
    } catch (e) {
      debugPrint("Error loading order status data: $e");
    }
  }

  @action
  Future<void> setPackagingOrder(PackagingResponse packaging, {bool isInitializing = false}) async {
    try {
      // 1️⃣ Convert the model to JSON
      final jsonString = jsonEncode(packaging.toJson());

      // 2️⃣ Optionally save it in SharedPreferences
      if (!isInitializing) {
        await setValue(SharePreferencesKey.packagingData, jsonString);
      }

      // 3️⃣ (Optional) Update store observables
      packagingOrder = packaging; // Assuming you have an observable for this
    } catch (e) {
      debugPrint("Error saving packaging data: $e");
    }
  }

  @action
  Future<void> setOrderStatus(OrderStatus orderStatus, {bool isInitializing = false}) async {
    try {
      // 1️⃣ Convert the model to JSON
      final jsonString = jsonEncode(orderStatus.toJson());

      // 2️⃣ Optionally save it in SharedPreferences
      if (!isInitializing) {
        await setValue(SharePreferencesKey.orderStatus, jsonString);
      }

      // 3️⃣ (Optional) Update store observables
      this.orderStatus = orderStatus; // Fixed potentially incorrect assignment
    } catch (e) {
      debugPrint("Error saving Order Status data: $e");
    }
  }

  @observable
  String selectedLanguageCode = DEFAULT_LANGUAGE;

  @action
  Future<void> setFcmToken(String? value, {bool isInitializing = false}) async {
    fcmToken = value;

    // 2️⃣ Optionally save it in SharedPreferences
    if (!isInitializing) {
      await setValue(SharePreferencesKey.fcmToken, fcmToken);
    }
  }

  @action
  Future<void> setLanguage(String val, {BuildContext? context}) async {
    selectedLanguageCode = val;

    await setValue(SELECTED_LANGUAGE_CODE, selectedLanguageCode);
    selectedLanguageDataModel = getSelectedLanguageModel();

    if (context != null) languages = Languages.of(context);
  }

  @action
  Future<void> dispose() async {
    // Enter the dispose methods
  }
}
