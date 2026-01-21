// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NotificationStore on _NotificationStore, Store {
  Computed<bool>? _$canLoadMoreComputed;

  @override
  bool get canLoadMore => (_$canLoadMoreComputed ??= Computed<bool>(
    () => super.canLoadMore,
    name: '_NotificationStore.canLoadMore',
  )).value;

  late final _$notificationsAtom = Atom(
    name: '_NotificationStore.notifications',
    context: context,
  );

  @override
  ObservableList<NotificationData> get notifications {
    _$notificationsAtom.reportRead();
    return super.notifications;
  }

  @override
  set notifications(ObservableList<NotificationData> value) {
    _$notificationsAtom.reportWrite(value, super.notifications, () {
      super.notifications = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_NotificationStore.isLoading',
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

  late final _$pageAtom = Atom(
    name: '_NotificationStore.page',
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
    name: '_NotificationStore.hasMore',
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

  late final _$fetchNotificationsAsyncAction = AsyncAction(
    '_NotificationStore.fetchNotifications',
    context: context,
  );

  @override
  Future<void> fetchNotifications({bool refresh = false}) {
    return _$fetchNotificationsAsyncAction.run(
      () => super.fetchNotifications(refresh: refresh),
    );
  }

  @override
  String toString() {
    return '''
notifications: ${notifications},
isLoading: ${isLoading},
page: ${page},
hasMore: ${hasMore},
canLoadMore: ${canLoadMore}
    ''';
  }
}
