import 'package:blueberry/view/alerts/alert_screen.dart';
import 'package:blueberry/view/home/home_screen.dart';
import 'package:blueberry/view/orders/order_screen.dart';
import 'package:blueberry/view/setting/setting_screen.dart';
import 'package:flutter/material.dart';

class DashboardModel {
  String? screenName;
  Widget? screen;
  int? index;
  DashboardModel({this.screenName, this.screen, this.index});
}

List<DashboardModel> getDashboardValue() {
  return [
    DashboardModel(index: 0, screenName: "Home", screen: HomeScreen()),
    DashboardModel(index: 1, screenName: "Orders", screen: OrderScreen()),
    DashboardModel(index: 2, screenName: "Settings", screen: SettingScreen()),
  ];
}
