// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_listing_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OrderListingStore on _OrderListingStore, Store {
  Computed<bool>? _$canLoadMoreComputed;

  @override
  bool get canLoadMore => (_$canLoadMoreComputed ??= Computed<bool>(
    () => super.canLoadMore,
    name: '_OrderListingStore.canLoadMore',
  )).value;
  Computed<List<OrderData>>? _$filteredOrdersComputed;

  @override
  List<OrderData> get filteredOrders =>
      (_$filteredOrdersComputed ??= Computed<List<OrderData>>(
        () => super.filteredOrders,
        name: '_OrderListingStore.filteredOrders',
      )).value;

  late final _$ordersAtom = Atom(
    name: '_OrderListingStore.orders',
    context: context,
  );

  @override
  ObservableList<OrderData> get orders {
    _$ordersAtom.reportRead();
    return super.orders;
  }

  @override
  set orders(ObservableList<OrderData> value) {
    _$ordersAtom.reportWrite(value, super.orders, () {
      super.orders = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_OrderListingStore.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$urgentOnlyAtom = Atom(
    name: '_OrderListingStore.urgentOnly',
    context: context,
  );

  @override
  bool get urgentOnly {
    _$urgentOnlyAtom.reportRead();
    return super.urgentOnly;
  }

  @override
  set urgentOnly(bool value) {
    _$urgentOnlyAtom.reportWrite(value, super.urgentOnly, () {
      super.urgentOnly = value;
    });
  }

  late final _$selectedStatusAtom = Atom(
    name: '_OrderListingStore.selectedStatus',
    context: context,
  );

  @override
  String get selectedStatus {
    _$selectedStatusAtom.reportRead();
    return super.selectedStatus;
  }

  @override
  set selectedStatus(String value) {
    _$selectedStatusAtom.reportWrite(value, super.selectedStatus, () {
      super.selectedStatus = value;
    });
  }

  late final _$searchTextAtom = Atom(
    name: '_OrderListingStore.searchText',
    context: context,
  );

  @override
  String get searchText {
    _$searchTextAtom.reportRead();
    return super.searchText;
  }

  @override
  set searchText(String value) {
    _$searchTextAtom.reportWrite(value, super.searchText, () {
      super.searchText = value;
    });
  }

  late final _$pageAtom = Atom(
    name: '_OrderListingStore.page',
    context: context,
  );

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  late final _$hasMoreAtom = Atom(
    name: '_OrderListingStore.hasMore',
    context: context,
  );

  @override
  bool get hasMore {
    _$hasMoreAtom.reportRead();
    return super.hasMore;
  }

  @override
  set hasMore(bool value) {
    _$hasMoreAtom.reportWrite(value, super.hasMore, () {
      super.hasMore = value;
    });
  }

  late final _$fetchOrdersAsyncAction = AsyncAction(
    '_OrderListingStore.fetchOrders',
    context: context,
  );

  @override
  Future<void> fetchOrders({bool refresh = false}) {
    return _$fetchOrdersAsyncAction.run(
      () => super.fetchOrders(refresh: refresh),
    );
  }

  late final _$_OrderListingStoreActionController = ActionController(
    name: '_OrderListingStore',
    context: context,
  );

  @override
  void toggleUrgent(bool value) {
    final _$actionInfo = _$_OrderListingStoreActionController.startAction(
      name: '_OrderListingStore.toggleUrgent',
    );
    try {
      return super.toggleUrgent(value);
    } finally {
      _$_OrderListingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeStatus(String status) {
    final _$actionInfo = _$_OrderListingStoreActionController.startAction(
      name: '_OrderListingStore.changeStatus',
    );
    try {
      return super.changeStatus(status);
    } finally {
      _$_OrderListingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateSearch(String value) {
    final _$actionInfo = _$_OrderListingStoreActionController.startAction(
      name: '_OrderListingStore.updateSearch',
    );
    try {
      return super.updateSearch(value);
    } finally {
      _$_OrderListingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
orders: ${orders},
isLoading: ${isLoading},
urgentOnly: ${urgentOnly},
selectedStatus: ${selectedStatus},
searchText: ${searchText},
page: ${page},
hasMore: ${hasMore},
canLoadMore: ${canLoadMore},
filteredOrders: ${filteredOrders}
    ''';
  }
}
