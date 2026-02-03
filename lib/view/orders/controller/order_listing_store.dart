import 'package:blueberry/utils/constant.dart';
import 'package:blueberry/view/orders/controller/order_controller.dart';
import 'package:blueberry/view/orders/model/order_response.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';

part 'order_listing_store.g.dart';

class OrderListingStore = _OrderListingStore with _$OrderListingStore;

abstract class _OrderListingStore with Store {
  // -------------------- Observables --------------------
  @observable
  ObservableList<OrderData> orders = ObservableList();

  @observable
  bool isLoading = false;

  @observable
  bool urgentOnly = false;

  @observable
  String selectedStatus = "Pending";

  @observable
  String searchText = '';

  @observable
  int page = 0;

  @observable
  bool hasMore = true;

  @computed
  bool get canLoadMore => hasMore && !isLoading;

  // -------------------- Actions --------------------
  @action
  Future<void> fetchOrders({bool refresh = false}) async {
    log("========1");
    if (isLoading) return;
    log("========2");

    if (refresh) {
      log("========3");

      page = 0;
      hasMore = true;
    }
    log("========4");

    if (!hasMore) return;
    log("========5");

    isLoading = true;
    if (refresh) orders.clear();

    try {
      log("========6");

      final res = await OrderController.getOrderListing(status: selectedStatus, page: page, perPage: perPage);

      final fetched = res.data ?? [];

      if (urgentOnly) {
        orders.addAll(fetched.where((e) => e.isUrgent == true));
      } else {
        orders.addAll(fetched);
      }

      hasMore = fetched.length == perPage;
      page++;
    } finally {
      isLoading = false;
    }
  }

  @action
  void toggleUrgent(bool value) {
    urgentOnly = value;
    fetchOrders(refresh: true);
  }

  @action
  void changeStatus(String status) {
    selectedStatus = status;
    fetchOrders(refresh: true);
  }

  @action
  void updateSearch(String value) {
    searchText = value;
  }

  // -------------------- Computed --------------------
  @computed
  List<OrderData> get filteredOrders {
    if (searchText.isEmpty) return orders.toList();

    return orders.where((o) => o.orderNumber.validate().toLowerCase().contains(searchText.toLowerCase()) || o.customerName.validate().toLowerCase().contains(searchText.toLowerCase())).toList();
  }
}
