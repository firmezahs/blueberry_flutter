// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on _UserStore, Store {
  Computed<String>? _$fullNameComputed;

  @override
  String get fullName => (_$fullNameComputed ??= Computed<String>(
    () => super.fullName,
    name: '_UserStore.fullName',
  )).value;
  Computed<bool>? _$isAdminComputed;

  @override
  bool get isAdmin => (_$isAdminComputed ??= Computed<bool>(
    () => super.isAdmin,
    name: '_UserStore.isAdmin',
  )).value;
  Computed<String>? _$mobileNumberComputed;

  @override
  String get mobileNumber => (_$mobileNumberComputed ??= Computed<String>(
    () => super.mobileNumber,
    name: '_UserStore.mobileNumber',
  )).value;

  late final _$employeeDataAtom = Atom(
    name: '_UserStore.employeeData',
    context: context,
  );

  @override
  EmployeeResponse? get employeeData {
    _$employeeDataAtom.reportRead();
    return super.employeeData;
  }

  @override
  set employeeData(EmployeeResponse? value) {
    _$employeeDataAtom.reportWrite(value, super.employeeData, () {
      super.employeeData = value;
    });
  }

  late final _$isLoggedInAtom = Atom(
    name: '_UserStore.isLoggedIn',
    context: context,
  );

  @override
  bool? get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool? value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  late final _$accessTokenAtom = Atom(
    name: '_UserStore.accessToken',
    context: context,
  );

  @override
  String? get accessToken {
    _$accessTokenAtom.reportRead();
    return super.accessToken;
  }

  @override
  set accessToken(String? value) {
    _$accessTokenAtom.reportWrite(value, super.accessToken, () {
      super.accessToken = value;
    });
  }

  late final _$setEmployeeDataAsyncAction = AsyncAction(
    '_UserStore.setEmployeeData',
    context: context,
  );

  @override
  Future<void> setEmployeeData(
    EmployeeResponse employee, {
    bool isInitializing = false,
  }) {
    return _$setEmployeeDataAsyncAction.run(
      () => super.setEmployeeData(employee, isInitializing: isInitializing),
    );
  }

  late final _$updateEmployeeProfileAsyncAction = AsyncAction(
    '_UserStore.updateEmployeeProfile',
    context: context,
  );

  @override
  Future<void> updateEmployeeProfile({String? alias, int? profilePic}) {
    return _$updateEmployeeProfileAsyncAction.run(
      () => super.updateEmployeeProfile(alias: alias, profilePic: profilePic),
    );
  }

  late final _$setAccessTokenAsyncAction = AsyncAction(
    '_UserStore.setAccessToken',
    context: context,
  );

  @override
  Future<void> setAccessToken(String val, {bool isInitializing = false}) {
    return _$setAccessTokenAsyncAction.run(
      () => super.setAccessToken(val, isInitializing: isInitializing),
    );
  }

  late final _$setLoggedInAsyncAction = AsyncAction(
    '_UserStore.setLoggedIn',
    context: context,
  );

  @override
  Future<void> setLoggedIn(bool val, {bool isInitializing = false}) {
    return _$setLoggedInAsyncAction.run(
      () => super.setLoggedIn(val, isInitializing: isInitializing),
    );
  }

  late final _$loadEmployeeDataAsyncAction = AsyncAction(
    '_UserStore.loadEmployeeData',
    context: context,
  );

  @override
  Future<void> loadEmployeeData() {
    return _$loadEmployeeDataAsyncAction.run(() => super.loadEmployeeData());
  }

  late final _$logoutAsyncAction = AsyncAction(
    '_UserStore.logout',
    context: context,
  );

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  @override
  String toString() {
    return '''
employeeData: ${employeeData},
isLoggedIn: ${isLoggedIn},
accessToken: ${accessToken},
fullName: ${fullName},
isAdmin: ${isAdmin},
mobileNumber: ${mobileNumber}
    ''';
  }
}
