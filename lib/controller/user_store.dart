import 'dart:convert';

import 'package:blueberry/main.dart';
import 'package:blueberry/utils/config.dart';
import 'package:blueberry/view/auth/model/employee_response.dart';
import 'package:blueberry/view/auth/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  @observable
  EmployeeResponse? employeeData;
  @observable
  bool? isLoggedIn;

  @observable
  String? accessToken;

  @action
  Future<void> setEmployeeData(EmployeeResponse employee, {bool isInitializing = false}) async {
    try {
      // 1️⃣ Convert the model to JSON
      final jsonString = jsonEncode(employee.toJson());

      // 2️⃣ Optionally save it in SharedPreferences
      if (!isInitializing) {
        await setValue(SharePreferencesKey.employeeData, jsonString);
      }

      // 3️⃣ (Optional) Update store observables
      employeeData = employee; // Assuming you have an observable for this
    } catch (e) {
      debugPrint("Error saving employee data: $e");
    }
  }

  @action
  Future<void> updateEmployeeProfile({String? alias, int? profilePic}) async {
    if (employeeData == null) return;

    final updated = employeeData!.copyWith(firstName: alias ?? employeeData!.firstName);

    await setEmployeeData(updated, isInitializing: false);
  }

  @action
  Future<void> setAccessToken(String val, {bool isInitializing = false}) async {
    accessToken = val;
    if (!isInitializing) await setValue(SharePreferencesKey.accessToken, val);
  }

  @action
  Future<void> setLoggedIn(bool val, {bool isInitializing = false}) async {
    isLoggedIn = val;
    if (!isInitializing) await setValue(SharePreferencesKey.loggedIn, val);
  }

  @action
  Future<void> loadEmployeeData() async {
    try {
      final jsonString = await getJSONAsync(SharePreferencesKey.employeeData);
      if (jsonString.isNotEmpty) {
        final Map<String, dynamic> json = jsonString;
        employeeData = EmployeeResponse.fromJson(json);
      }
    } catch (e) {
      debugPrint("Error loading employee data: $e");
    }
  }

  // =============================
  // 🧠 Computed Getters
  // =============================

  @computed
  String get fullName {
    final f = employeeData?.firstName ?? '';
    final l = employeeData?.lastName ?? '';
    return (f + ' ' + l).trim();
  }

  @computed
  bool get isAdmin {
    return employeeData?.role.validate() == "Employee" ? false : true;
  }

  @computed
  String get mobileNumber {
    return employeeData!.mobileNumber.validate();
    // return AppConfig.imageUrl(folderName: "employee", imageName: employeeData?.profilePic ?? '');
  }

  @action
  Future<void> logout() async {
    await removeKey(SharePreferencesKey.accessToken);
    await removeKey(SharePreferencesKey.loggedIn);
    await removeKey(SharePreferencesKey.employeeData);
    accessToken = null;
    isLoggedIn = false;
    employeeData = null;

    dashboardStore.setCurrentIndex(0);
    SignInScreen().launch(getContext, isNewTask: true);
  }
}
