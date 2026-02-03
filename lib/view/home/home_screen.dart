import 'package:ag_widgets/widgets/ag_app_button.dart';
import 'package:blueberry/main.dart';
import 'package:blueberry/network/api_client.dart';
import 'package:blueberry/view/dashboard/controller/dashboard_controller.dart';
import 'package:blueberry/view/dashboard/model/dashboard_response.dart';
import 'package:blueberry/view/orders/add_order_view.dart';
import 'package:blueberry/view/orders/controller/add_order_store.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<DashboardResponse>? future;
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    future = DashboardController.dashboardApi();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        initialData: dashboardStore.initialDashboardResponse,
        future: future,
        builder: (context, snap) {
          if (snap.hasData) {
            return AnimatedScrollView(
              listAnimationType: ListAnimationType.None,
              padding: EdgeInsets.all(10),
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Container(
                      width: (context.width() / 2) - 14,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: context.cardColor,
                        borderRadius: radius(),
                        boxShadow: defaultBoxShadow(shadowColor: Color(0xFFEFF6FF)),
                        border: Border.all(color: Color(0xFF2563EB)),
                      ),
                      child: Column(
                        crossAxisAlignment: .start,
                        mainAxisSize: .min,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(color: Color(0xFFEFF6FF), borderRadius: radius()),
                                child: Icon(Icons.inventory_2_rounded, color: Color(0xFF2563EB)),
                              ),
                              Spacer(),
                              Text(snap.data!.totalOrders.toString(), style: boldTextStyle(size: 28)),
                            ],
                          ),
                          8.height,

                          Text("Total Orders", style: secondaryTextStyle()),
                        ],
                      ),
                    ),
                    Container(
                      width: (context.width() / 2) - 14,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: context.cardColor,
                        borderRadius: radius(),
                        boxShadow: defaultBoxShadow(shadowColor: Color(0xFFFEF2F2)),
                        border: Border.all(color: Color(0xFFDC2626)),
                      ),
                      child: Column(
                        crossAxisAlignment: .start,
                        mainAxisSize: .min,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(color: Color(0xFFFEF2F2), borderRadius: radius()),
                                child: Icon(Icons.priority_high, color: Color(0xFFDC2626)),
                              ),
                              Spacer(),
                              Text(snap.data!.urgentOrders.toString(), style: boldTextStyle(size: 28)),
                            ],
                          ),
                          8.height,
                          Text("Urgent Orders", style: secondaryTextStyle()),
                        ],
                      ),
                    ),
                    Container(
                      width: (context.width() / 2) - 14,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: context.cardColor,
                        borderRadius: radius(),
                        boxShadow: defaultBoxShadow(shadowColor: Color(0xFFEFF6FF)),
                        border: Border.all(color: Color(0xFF7C3AED)),
                      ),
                      child: Column(
                        crossAxisAlignment: .start,
                        mainAxisSize: .min,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(color: Color(0xFFF3E8FF), borderRadius: radius()),
                                child: Icon(Icons.hourglass_top_rounded, color: Color(0xFF7C3AED)),
                              ),
                              Spacer(),
                              Text(snap.data!.pending.toString(), style: boldTextStyle(size: 28)),
                            ],
                          ),
                          8.height,

                          Text("Pending", style: secondaryTextStyle()),
                        ],
                      ),
                    ),
                    Container(
                      width: (context.width() / 2) - 14,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: context.cardColor,
                        borderRadius: radius(),
                        boxShadow: defaultBoxShadow(shadowColor: Color(0xFFEFF6FF)),
                        border: Border.all(color: Color(0xFFCC3AED)),
                      ),
                      child: Column(
                        crossAxisAlignment: .start,
                        mainAxisSize: .min,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(color: Color(0xFFF3E8FF), borderRadius: radius()),
                                child: Icon(Icons.hourglass_top_rounded, color: Color(0xFFCC3AED)),
                              ),
                              Spacer(),
                              Text(snap.data!.partialDispatched.toString(), style: boldTextStyle(size: 28)),
                            ],
                          ),
                          8.height,

                          Text("Partial Dispatched", style: secondaryTextStyle()),
                        ],
                      ),
                    ),
                    Container(
                      width: (context.width() / 2) - 14,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: context.cardColor,
                        borderRadius: radius(),
                        boxShadow: defaultBoxShadow(shadowColor: Color(0xFFECFDF5)),
                        border: Border.all(color: Color(0xFF059669)),
                      ),
                      child: Column(
                        crossAxisAlignment: .start,
                        mainAxisSize: .min,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(color: Color(0xFFECFDF5), borderRadius: radius()),
                                child: Icon(Icons.local_shipping_rounded, color: Color(0xFF059669)),
                              ),
                              Spacer(),
                              Text(snap.data!.dispatched.toString(), style: boldTextStyle(size: 28)),
                            ],
                          ),

                          8.height,

                          Text("Dispatched", style: secondaryTextStyle()),
                        ],
                      ),
                    ),
                  ],
                ),
                16.height,
                AgAppButton(
                  borderRadius: defaultRadius,
                  text: "New Order",
                  solidColor: context.primaryColor,
                  icon: Icon(Icons.add, color: Colors.white),
                  onPressed: () async {
                    dashboardStore.setCurrentIndex(1);
                    addOrderStore = AddOrderStore();
                    await AddOrderScreen().launch(context);
                  },
                ),
                20.height,
              ],
            );
          }
          return snapWidgetHelper(snap);
        },
      ),
    );
  }
}
