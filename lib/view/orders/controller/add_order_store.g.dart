// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_order_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddOrderStore on _AddOrderStore, Store {
  late final _$packagingSelectionsAtom = Atom(
    name: '_AddOrderStore.packagingSelections',
    context: context,
  );

  @override
  ObservableMap<String, bool> get packagingSelections {
    _$packagingSelectionsAtom.reportRead();
    return super.packagingSelections;
  }

  @override
  set packagingSelections(ObservableMap<String, bool> value) {
    _$packagingSelectionsAtom.reportWrite(value, super.packagingSelections, () {
      super.packagingSelections = value;
    });
  }

  late final _$isUrgentAtom = Atom(
    name: '_AddOrderStore.isUrgent',
    context: context,
  );

  @override
  bool get isUrgent {
    _$isUrgentAtom.reportRead();
    return super.isUrgent;
  }

  @override
  set isUrgent(bool value) {
    _$isUrgentAtom.reportWrite(value, super.isUrgent, () {
      super.isUrgent = value;
    });
  }

  late final _$productsAtom = Atom(
    name: '_AddOrderStore.products',
    context: context,
  );

  @override
  ObservableList<OrderItems> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(ObservableList<OrderItems> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_AddOrderStore.isLoading',
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

  late final _$submitOrderAsyncAction = AsyncAction(
    '_AddOrderStore.submitOrder',
    context: context,
  );

  @override
  Future<void> submitOrder() {
    return _$submitOrderAsyncAction.run(() => super.submitOrder());
  }

  late final _$editOrderAsyncAction = AsyncAction(
    '_AddOrderStore.editOrder',
    context: context,
  );

  @override
  Future<void> editOrder({required int orderId}) {
    return _$editOrderAsyncAction.run(() => super.editOrder(orderId: orderId));
  }

  late final _$_AddOrderStoreActionController = ActionController(
    name: '_AddOrderStore',
    context: context,
  );

  @override
  void initPackagingOptions(List<String> options) {
    final _$actionInfo = _$_AddOrderStoreActionController.startAction(
      name: '_AddOrderStore.initPackagingOptions',
    );
    try {
      return super.initPackagingOptions(options);
    } finally {
      _$_AddOrderStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void togglePackaging(String key, bool value) {
    final _$actionInfo = _$_AddOrderStoreActionController.startAction(
      name: '_AddOrderStore.togglePackaging',
    );
    try {
      return super.togglePackaging(key, value);
    } finally {
      _$_AddOrderStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleUrgent(bool v) {
    final _$actionInfo = _$_AddOrderStoreActionController.startAction(
      name: '_AddOrderStore.toggleUrgent',
    );
    try {
      return super.toggleUrgent(v);
    } finally {
      _$_AddOrderStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addProduct() {
    final _$actionInfo = _$_AddOrderStoreActionController.startAction(
      name: '_AddOrderStore.addProduct',
    );
    try {
      return super.addProduct();
    } finally {
      _$_AddOrderStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void editProduct(int index) {
    final _$actionInfo = _$_AddOrderStoreActionController.startAction(
      name: '_AddOrderStore.editProduct',
    );
    try {
      return super.editProduct(index);
    } finally {
      _$_AddOrderStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeProduct(int index) {
    final _$actionInfo = _$_AddOrderStoreActionController.startAction(
      name: '_AddOrderStore.removeProduct',
    );
    try {
      return super.removeProduct(index);
    } finally {
      _$_AddOrderStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
packagingSelections: ${packagingSelections},
isUrgent: ${isUrgent},
products: ${products},
isLoading: ${isLoading}
    ''';
  }
}
