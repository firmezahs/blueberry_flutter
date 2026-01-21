// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OrderDetailStore on _OrderDetailStore, Store {
  late final _$isLoadingAtom = Atom(
    name: '_OrderDetailStore.isLoading',
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
    name: '_OrderDetailStore.order',
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

  late final _$fetchOrderDetailAsyncAction = AsyncAction(
    '_OrderDetailStore.fetchOrderDetail',
    context: context,
  );

  @override
  Future<void> fetchOrderDetail(int orderId) {
    return _$fetchOrderDetailAsyncAction.run(
      () => super.fetchOrderDetail(orderId),
    );
  }

  late final _$updateOrderStatusAsyncAction = AsyncAction(
    '_OrderDetailStore.updateOrderStatus',
    context: context,
  );

  @override
  Future<void> updateOrderStatus({required String orderId, String? status}) {
    return _$updateOrderStatusAsyncAction.run(
      () => super.updateOrderStatus(orderId: orderId, status: status),
    );
  }

  late final _$_OrderDetailStoreActionController = ActionController(
    name: '_OrderDetailStore',
    context: context,
  );

  @override
  void toggleItemUpdate(int itemId, bool value) {
    final _$actionInfo = _$_OrderDetailStoreActionController.startAction(
      name: '_OrderDetailStore.toggleItemUpdate',
    );
    try {
      return super.toggleItemUpdate(itemId, value);
    } finally {
      _$_OrderDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleAll(bool value) {
    final _$actionInfo = _$_OrderDetailStoreActionController.startAction(
      name: '_OrderDetailStore.toggleAll',
    );
    try {
      return super.toggleAll(value);
    } finally {
      _$_OrderDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
order: ${order}
    ''';
  }
}
