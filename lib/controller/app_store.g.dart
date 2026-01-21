// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on AppStoreBase, Store {
  late final _$isDarkModeOnAtom = Atom(
    name: 'AppStoreBase.isDarkModeOn',
    context: context,
  );

  @override
  bool get isDarkModeOn {
    _$isDarkModeOnAtom.reportRead();
    return super.isDarkModeOn;
  }

  @override
  set isDarkModeOn(bool value) {
    _$isDarkModeOnAtom.reportWrite(value, super.isDarkModeOn, () {
      super.isDarkModeOn = value;
    });
  }

  late final _$fcmTokenAtom = Atom(
    name: 'AppStoreBase.fcmToken',
    context: context,
  );

  @override
  String? get fcmToken {
    _$fcmTokenAtom.reportRead();
    return super.fcmToken;
  }

  @override
  set fcmToken(String? value) {
    _$fcmTokenAtom.reportWrite(value, super.fcmToken, () {
      super.fcmToken = value;
    });
  }

  late final _$packagingOrderAtom = Atom(
    name: 'AppStoreBase.packagingOrder',
    context: context,
  );

  @override
  PackagingResponse? get packagingOrder {
    _$packagingOrderAtom.reportRead();
    return super.packagingOrder;
  }

  @override
  set packagingOrder(PackagingResponse? value) {
    _$packagingOrderAtom.reportWrite(value, super.packagingOrder, () {
      super.packagingOrder = value;
    });
  }

  late final _$orderStatusAtom = Atom(
    name: 'AppStoreBase.orderStatus',
    context: context,
  );

  @override
  OrderStatus? get orderStatus {
    _$orderStatusAtom.reportRead();
    return super.orderStatus;
  }

  @override
  set orderStatus(OrderStatus? value) {
    _$orderStatusAtom.reportWrite(value, super.orderStatus, () {
      super.orderStatus = value;
    });
  }

  late final _$selectedLanguageCodeAtom = Atom(
    name: 'AppStoreBase.selectedLanguageCode',
    context: context,
  );

  @override
  String get selectedLanguageCode {
    _$selectedLanguageCodeAtom.reportRead();
    return super.selectedLanguageCode;
  }

  @override
  set selectedLanguageCode(String value) {
    _$selectedLanguageCodeAtom.reportWrite(
      value,
      super.selectedLanguageCode,
      () {
        super.selectedLanguageCode = value;
      },
    );
  }

  late final _$initAsyncAction = AsyncAction(
    'AppStoreBase.init',
    context: context,
  );

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$loadPackagingDataAsyncAction = AsyncAction(
    'AppStoreBase.loadPackagingData',
    context: context,
  );

  @override
  Future<void> loadPackagingData() {
    return _$loadPackagingDataAsyncAction.run(() => super.loadPackagingData());
  }

  late final _$loadOrderStatusDataAsyncAction = AsyncAction(
    'AppStoreBase.loadOrderStatusData',
    context: context,
  );

  @override
  Future<void> loadOrderStatusData() {
    return _$loadOrderStatusDataAsyncAction.run(
      () => super.loadOrderStatusData(),
    );
  }

  late final _$setPackagingOrderAsyncAction = AsyncAction(
    'AppStoreBase.setPackagingOrder',
    context: context,
  );

  @override
  Future<void> setPackagingOrder(
    PackagingResponse packaging, {
    bool isInitializing = false,
  }) {
    return _$setPackagingOrderAsyncAction.run(
      () => super.setPackagingOrder(packaging, isInitializing: isInitializing),
    );
  }

  late final _$setOrderStatusAsyncAction = AsyncAction(
    'AppStoreBase.setOrderStatus',
    context: context,
  );

  @override
  Future<void> setOrderStatus(
    OrderStatus orderStatus, {
    bool isInitializing = false,
  }) {
    return _$setOrderStatusAsyncAction.run(
      () => super.setOrderStatus(orderStatus, isInitializing: isInitializing),
    );
  }

  late final _$setDarkModeStatusAsyncAction = AsyncAction(
    'AppStoreBase.setDarkModeStatus',
    context: context,
  );

  @override
  Future<void> setDarkModeStatus(bool value) {
    return _$setDarkModeStatusAsyncAction.run(
      () => super.setDarkModeStatus(value),
    );
  }

  late final _$setFcmTokenAsyncAction = AsyncAction(
    'AppStoreBase.setFcmToken',
    context: context,
  );

  @override
  Future<void> setFcmToken(String? value, {bool isInitializing = false}) {
    return _$setFcmTokenAsyncAction.run(
      () => super.setFcmToken(value, isInitializing: isInitializing),
    );
  }

  late final _$setLanguageAsyncAction = AsyncAction(
    'AppStoreBase.setLanguage',
    context: context,
  );

  @override
  Future<void> setLanguage(String val, {BuildContext? context}) {
    return _$setLanguageAsyncAction.run(
      () => super.setLanguage(val, context: context),
    );
  }

  late final _$disposeAsyncAction = AsyncAction(
    'AppStoreBase.dispose',
    context: context,
  );

  @override
  Future<void> dispose() {
    return _$disposeAsyncAction.run(() => super.dispose());
  }

  @override
  String toString() {
    return '''
isDarkModeOn: ${isDarkModeOn},
fcmToken: ${fcmToken},
packagingOrder: ${packagingOrder},
orderStatus: ${orderStatus},
selectedLanguageCode: ${selectedLanguageCode}
    ''';
  }
}
