import 'package:blueberry/network/api_client.dart';
import 'package:blueberry/view/auth/model/employee_response.dart';

class OrderResponse {
  final String? message;
  final int? total;
  final List<OrderData>? data;

  const OrderResponse({this.message, this.total, this.data});

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      message: json['message'] as String?,
      total: json['total'] as int?,
      data: json['data'] != null ? (json['data'] as List).map((e) => OrderData.fromJson(e as Map<String, dynamic>)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'total': total, 'data': data?.map((e) => e.toJson()).toList()};
  }

  OrderResponse copyWith({String? message, int? total, List<OrderData>? data}) {
    return OrderResponse(message: message ?? this.message, total: total ?? this.total, data: data ?? this.data);
  }
}

class Product {
  final int? id;
  final String? name;
  final String? description;

  const Product({this.id, this.name, this.description});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(id: json['id'] as int?, name: json['name'] as String?, description: json['description']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description};
  }

  Product copyWith({int? id, String? name, dynamic? description}) {
    return Product(id: id ?? this.id, name: name ?? this.name, description: description ?? this.description);
  }
}

class OrderItems {
  final int? id;
  final Product? product;
  final int? quantity;
  final String? marking;
  String? status;
  final List<String>? packaging;

  bool? isUpdate = true;
  int? currentIndex;

  OrderItems({this.id, this.product, this.quantity, this.marking, this.packaging, this.status});

  factory OrderItems.fromJson(Map<String, dynamic> json) {
    return OrderItems(
      id: json['id'] as int?,
      product: json['product'] != null ? Product.fromJson(json['product'] as Map<String, dynamic>) : null,
      quantity: json['quantity'] as int?,
      marking: json['marking'] as String?,
      status: json['status'] as String?,
      packaging: json['packaging'] != null
          ? json['packaging'] is String
                ? json['packaging'].toString().split(",")
                : List.from(json['packaging'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'product': product?.toJson(), 'quantity': quantity, 'marking': marking, 'status': status, 'packaging': packaging};
  }

  Map<String, dynamic> toSaveJson() {
    return {'product_name': product!.name.validate(), 'quantity': quantity, 'marking': marking, 'packaging': packaging, 'status': status};
  }

  OrderItems copyWith({int? id, Product? product, int? quantity, String? marking, String? packaging, String? status}) {
    return OrderItems(id: id ?? this.id, product: product ?? this.product, quantity: quantity ?? this.quantity, marking: marking ?? this.marking, status: status ?? this.status);
  }
}

class OrderData {
  final int? id;
  final EmployeeResponse? employee;
  final String? orderNumber;
  final String? customerName;
  final String? note;
  final bool? isUrgent;
  final String? orderStatus;
  final List<OrderItems>? orderItems;
  final int? createdBy;
  final String? createdAt;
  final String? updatedAt;
  final int? orderItemsCount;

  const OrderData({
    this.id,
    this.employee,
    this.orderNumber,
    this.customerName,
    this.note,
    this.isUrgent,
    this.orderStatus,
    this.orderItems,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.orderItemsCount,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      id: json['id'] as int?,
      employee: json['order_status_updated_by'] != null ? EmployeeResponse.fromJson(json['order_status_updated_by'] as Map<String, dynamic>) : null,
      orderNumber: json['order_number'] as String?,
      customerName: json['customer_name'] as String?,
      note: json['note'] as String?,
      isUrgent: json['is_urgent'] as bool?,
      orderStatus: json['order_status'] as String?,
      orderItems: json['order_items'] != null ? (json['order_items'] as List).map((e) => OrderItems.fromJson(e as Map<String, dynamic>)).toList() : null,
      createdBy: json['created_by'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      orderItemsCount: json['order_items_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee': employee?.toJson(),
      'order_number': orderNumber,
      'customer_name': customerName,
      'note': note,
      'is_urgent': isUrgent,
      'order_status': orderStatus,
      'order_items': orderItems?.map((e) => e.toJson()).toList(),
      'created_by': createdBy,
    };
  }

  OrderData copyWith({
    int? id,
    EmployeeResponse? employee,
    String? orderNumber,
    String? customerName,
    String? note,
    bool? isUrgent,
    String? orderStatus,
    List<OrderItems>? orderItems,
    int? createdBy,
  }) {
    return OrderData(
      id: id ?? this.id,
      employee: employee ?? this.employee,
      orderNumber: orderNumber ?? this.orderNumber,
      customerName: customerName ?? this.customerName,
      note: note ?? this.note,
      isUrgent: isUrgent ?? this.isUrgent,
      orderStatus: orderStatus ?? this.orderStatus,
      orderItems: orderItems ?? this.orderItems,
      createdBy: createdBy ?? this.createdBy,
    );
  }
}
