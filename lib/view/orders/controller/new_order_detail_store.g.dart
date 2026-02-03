// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_order_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NewOrderDetailStore on _NewOrderDetailStore, Store {
  Computed<bool>? _$isAllSelectedComputed;

  @override
  bool get isAllSelected => (_$isAllSelectedComputed ??= Computed<bool>(
    () => super.isAllSelected,
    name: '_NewOrderDetailStore.isAllSelected',
  )).value;

  late final _$isLoadingAtom = Atom(
    name: '_NewOrderDetailStore.isLoading',
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

  late final _$orderAtom = Atom(
    name: '_NewOrderDetailStore.order',
    context: context,
  );

  @override
  OrderData? get order {
    _$orderAtom.reportRead();
    return super.order;
  }

  @override
  set order(OrderData? value) {
    _$orderAtom.reportWrite(value, super.order, () {
      super.order = value;
    });
  }

  late final _$selectedItemsAtom = Atom(
    name: '_NewOrderDetailStore.selectedItems',
    context: context,
  );

  @override
  ObservableMap<int, bool> get selectedItems {
    _$selectedItemsAtom.reportRead();
    return super.selectedItems;
  }

  @override
  set selectedItems(ObservableMap<int, bool> value) {
    _$selectedItemsAtom.reportWrite(value, super.selectedItems, () {
      super.selectedItems = value;
    });
  }

  late final _$dispatchQtyControllersAtom = Atom(
    name: '_NewOrderDetailStore.dispatchQtyControllers',
    context: context,
  );

  @override
  ObservableMap<int, TextEditingController> get dispatchQtyControllers {
    _$dispatchQtyControllersAtom.reportRead();
    return super.dispatchQtyControllers;
  }

  @override
  set dispatchQtyControllers(ObservableMap<int, TextEditingController> value) {
    _$dispatchQtyControllersAtom.reportWrite(
      value,
      super.dispatchQtyControllers,
      () {
        super.dispatchQtyControllers = value;
      },
    );
  }

  late final _$fetchOrderDetailAsyncAction = AsyncAction(
    '_NewOrderDetailStore.fetchOrderDetail',
    context: context,
  );

  @override
  Future<void> fetchOrderDetail(int orderId) {
    return _$fetchOrderDetailAsyncAction.run(
      () => super.fetchOrderDetail(orderId),
    );
  }

  late final _$updateStatusAsyncAction = AsyncAction(
    '_NewOrderDetailStore.updateStatus',
    context: context,
  );

  @override
  Future<void> updateStatus() {
    return _$updateStatusAsyncAction.run(() => super.updateStatus());
  }

  late final _$revertStatusAsyncAction = AsyncAction(
    '_NewOrderDetailStore.revertStatus',
    context: context,
  );

  @override
  Future<void> revertStatus(int statusId, int orderItemId) {
    return _$revertStatusAsyncAction.run(
      () => super.revertStatus(statusId, orderItemId),
    );
  }

  late final _$_NewOrderDetailStoreActionController = ActionController(
    name: '_NewOrderDetailStore',
    context: context,
  );

  @override
  void toggleSelection(int itemId, bool? value) {
    final _$actionInfo = _$_NewOrderDetailStoreActionController.startAction(
      name: '_NewOrderDetailStore.toggleSelection',
    );
    try {
      return super.toggleSelection(itemId, value);
    } finally {
      _$_NewOrderDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleSelectAll(bool? value) {
    final _$actionInfo = _$_NewOrderDetailStoreActionController.startAction(
      name: '_NewOrderDetailStore.toggleSelectAll',
    );
    try {
      return super.toggleSelectAll(value);
    } finally {
      _$_NewOrderDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
order: ${order},
selectedItems: ${selectedItems},
dispatchQtyControllers: ${dispatchQtyControllers},
isAllSelected: ${isAllSelected}
    ''';
  }
}
