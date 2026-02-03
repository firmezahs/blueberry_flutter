import 'package:blueberry/view/orders/model/order_response.dart';

class DashboardResponse {
  final String? message;
  final int? totalOrders;
  final int? pending;
  final int? dispatched;
  final int? urgentOrders;
  final int? partialDispatched;
  final List<OrderData>? orderData;

  const DashboardResponse({this.message, this.totalOrders, this.pending, this.dispatched, this.urgentOrders, this.orderData, this.partialDispatched});

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      message: json['message'] as String?,
      totalOrders: json['total_orders'] as int?,
      pending: json['pending'] as int?,
      dispatched: json['dispatched'] as int?,
      urgentOrders: json['urgent_orders'] as int?,
      partialDispatched: json['partial_dispatched'] as int?,
      orderData: json['data'] != null ? (json['data'] as List).map((e) => OrderData.fromJson(e as Map<String, dynamic>)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'total_orders': totalOrders,
      'partial_dispatched': partialDispatched,
      'pending': pending,
      'dispatched': dispatched,
      'urgent_orders': urgentOrders,
      'data': orderData?.map((e) => e.toJson()).toList(),
    };
  }

  DashboardResponse copyWith({String? message, int? totalOrders, int? pending, int? dispatched, int? partialDispatched, int? urgentOrders, List<OrderData>? data}) {
    return DashboardResponse(
      message: message ?? this.message,
      totalOrders: totalOrders ?? this.totalOrders,
      pending: pending ?? this.pending,
      dispatched: dispatched ?? this.dispatched,
      partialDispatched: partialDispatched ?? this.partialDispatched,
      urgentOrders: urgentOrders ?? this.urgentOrders,
      orderData: data ?? this.orderData,
    );
  }
}

class OrderStatusUpdatedBy {
  final int? id;
  final String? firstName;
  final String? lastName;
  final dynamic? aliasName;
  final String? email;
  final String? mobileNumber;
  final dynamic? accessToken;
  final String? role;

  const OrderStatusUpdatedBy({this.id, this.firstName, this.lastName, this.aliasName, this.email, this.mobileNumber, this.accessToken, this.role});

  factory OrderStatusUpdatedBy.fromJson(Map<String, dynamic> json) {
    return OrderStatusUpdatedBy(
      id: json['id'] as int?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      aliasName: json['alias_name'],
      email: json['email'] as String?,
      mobileNumber: json['mobile_number'] as String?,
      accessToken: json['access_token'],
      role: json['role'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'first_name': firstName, 'last_name': lastName, 'alias_name': aliasName, 'email': email, 'mobile_number': mobileNumber, 'access_token': accessToken, 'role': role};
  }

  OrderStatusUpdatedBy copyWith({int? id, String? firstName, String? lastName, dynamic? aliasName, String? email, String? mobileNumber, dynamic? accessToken, String? role}) {
    return OrderStatusUpdatedBy(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      aliasName: aliasName ?? this.aliasName,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      accessToken: accessToken ?? this.accessToken,
      role: role ?? this.role,
    );
  }
}
