import 'package:blueberry/network/api_client.dart';
import 'package:blueberry/utils/constant.dart';
import 'package:blueberry/view/alerts/model/notification_response.dart';
import 'package:blueberry/view/dashboard/controller/dashboard_controller.dart';
import 'package:mobx/mobx.dart';

part 'notification_store.g.dart';

class NotificationStore = _NotificationStore with _$NotificationStore;

abstract class _NotificationStore with Store {
  // ---------------- Observables ----------------
  @observable
  ObservableList<NotificationData> notifications = ObservableList();

  @observable
  bool isLoading = false;

  @observable
  int page = 1;

  @observable
  bool hasMore = true;

  // ---------------- Computed ----------------
  @computed
  bool get canLoadMore => hasMore && !isLoading;

  // ---------------- Actions ----------------
  @action
  Future<void> fetchNotifications({bool refresh = false}) async {
    if (refresh) {
      page = 1;
      hasMore = true;
      notifications.clear();
    }

    if (!hasMore || isLoading) return;

    isLoading = true;

    try {
      /// 🔹 Replace with your API call
      final res = await DashboardController.notificationApi(page: page, perPage: perPage);

      notifications.addAll(res.data.validate());

      hasMore = res.data.validate().length == perPage;
      page++;
    } finally {
      isLoading = false;
    }
  }
}
