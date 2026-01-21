import 'package:blueberry/view/dashboard/model/dashboard_response.dart';
import 'package:mobx/mobx.dart';

part 'dashboard_store.g.dart';

class DashboardStore = DashboardStoreBase with _$DashboardStore;

abstract class DashboardStoreBase with Store {
  @observable
  int currentIndex = 0;

  @action
  void setCurrentIndex(int val) {
    currentIndex = val;
  }

  @observable
  DashboardResponse? initialDashboardResponse;

  @action
  Future<void> dispose() async {
    // Enter the dispose methods
  }
}
