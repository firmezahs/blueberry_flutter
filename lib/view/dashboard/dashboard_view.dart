import 'package:ag_widgets/widgets/ag_cached_image.dart';
import 'package:blueberry/main.dart';
import 'package:blueberry/view/alerts/alert_screen.dart';
import 'package:blueberry/view/dashboard/model/dashboard_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  List<DashboardModel> dashboardList = getDashboardValue();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (userStore.employeeData == null) {
          return Offstage();
        }
        return Scaffold(
          appBar: dashboardStore.currentIndex != 2
              ? AppBar(
                  leading: AgCachedImage(
                    imageUrl: "",
                    isProfile: true,
                    size: 36,
                    name: userStore.employeeData!.firstName.validate() + " ${userStore.employeeData!.lastName.validate()}",
                  ).paddingOnly(right: 8, top: 8, bottom: 8, left: 8),
                  actions: [
                    IconButton(
                      onPressed: () {
                        NotificationScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
                      },
                      icon: Icon(Icons.notifications_none),
                    ),
                  ],
                  titleSpacing: 8,
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Hello, ${userStore.employeeData!.firstName.validate()}", style: boldTextStyle()),
                      2.height,
                      Text("${DateFormat('EEEE ,dd, MMM yy').format(DateTime.now())}", style: secondaryTextStyle(size: 12)),
                    ],
                  ),
                )
              : null,
          body: dashboardList[dashboardStore.currentIndex].screen.validate(),
          bottomNavigationBar: NavigationBar(
            selectedIndex: dashboardStore.currentIndex,
            onDestinationSelected: dashboardStore.setCurrentIndex,
            destinations: [
              NavigationDestination(icon: Icon(Icons.home), label: "Home"),
              NavigationDestination(icon: Icon(Icons.note_alt_outlined), label: "Orders"),
              NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
            ],
          ),
        );
      },
    );
  }
}
