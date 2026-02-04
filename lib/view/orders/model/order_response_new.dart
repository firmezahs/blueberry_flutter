class AddedBy {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? aliasName;
  final String? email;
  final String? mobileNumber;
  final String? accessToken;
  final String? role;

  const AddedBy({this.id, this.firstName, this.lastName, this.aliasName, this.email, this.mobileNumber, this.accessToken, this.role});

  factory AddedBy.fromJson(Map<String, dynamic> json) {
    return AddedBy(
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

  AddedBy copyWith({int? id, String? firstName, String? lastName, String? aliasName, String? email, String? mobileNumber, String? accessToken, String? role}) {
    return AddedBy(
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

class OrderStatus {
  final int? id;
  final int? orderItemId;
  final int? orderId;
  final AddedBy? addedBy;
  final Product? product;
  final String? status;
  final int? dispatchQuantity;
  final DateTime? createdAt;

  const OrderStatus({this.id, this.orderItemId, this.orderId, this.addedBy, this.product, this.status, this.dispatchQuantity, this.createdAt});

  factory OrderStatus.fromJson(Map<String, dynamic> json) {
    return OrderStatus(
      id: json['id'] as int?,
      orderItemId: json['order_item_id'],
      orderId: json['order_id'] as int?,
      addedBy: json['added_by'] != null ? AddedBy.fromJson(json['added_by'] as Map<String, dynamic>) : null,
      product: json['product'] != null ? Product.fromJson(json['product']) : null,
      status: json['status'] as String?,
      dispatchQuantity: json['dispatch_quantity'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_item_id': orderItemId,
      'order_id': orderId,
      'added_by': addedBy?.toJson(),
      'product': product,
      'status': status,
      'dispatch_quantity': dispatchQuantity,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  OrderStatus copyWith({int? id, int? orderItemId, int? orderId, AddedBy? addedBy, Product? product, String? status, int? dispatchQuantity, DateTime? createdAt}) {
    return OrderStatus(
      id: id ?? this.id,
      orderItemId: orderItemId ?? this.orderItemId,
      orderId: orderId ?? this.orderId,
      addedBy: addedBy ?? this.addedBy,
      product: product ?? this.product,
      status: status ?? this.status,
      dispatchQuantity: dispatchQuantity ?? this.dispatchQuantity,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class OrderStatusUpdatedBy {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? aliasName;
  final String? email;
  final String? mobileNumber;
  final String? accessToken;
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

  OrderStatusUpdatedBy copyWith({int? id, String? firstName, String? lastName, String? aliasName, String? email, String? mobileNumber, String? accessToken, String? role}) {
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

  Product copyWith({int? id, String? name, String? description}) {
    return Product(id: id ?? this.id, name: name ?? this.name, description: description ?? this.description);
  }
}

class OrderItems {
  final int? id;
  final Product? product;
  final int? quantity;
  final int? dispatchedQuantity;
  final String? marking;
  final List<String>? packaging;
  final String? pendingAt;
  final String? dispatchedAt;
  final String? status;

  const OrderItems({this.id, this.product, this.quantity, this.dispatchedQuantity, this.marking, this.packaging, this.pendingAt, this.dispatchedAt, this.status});

  factory OrderItems.fromJson(Map<String, dynamic> json) {
    return OrderItems(
      id: json['id'] as int?,
      product: json['product'] != null ? Product.fromJson(json['product'] as Map<String, dynamic>) : null,
      quantity: json['quantity'] as int?,
      dispatchedQuantity: json['dispatched_quantity'] as int?,
      marking: json['marking'] as String?,
      packaging: json['packaging'] != null ? List<String>.from(json['packaging']) : null,
      pendingAt: json['pending_at'] as String?,
      dispatchedAt: json['dispatched_at'] as String?,
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product?.toJson(),
      'quantity': quantity,
      'dispatched_quantity': dispatchedQuantity,
      'marking': marking,
      'packaging': packaging,
      'pending_at': pendingAt,
      'dispatched_at': dispatchedAt,
      'status': status,
    };
  }

  OrderItems copyWith({int? id, Product? product, int? quantity, int? dispatchedQuantity, String? marking, List<String>? packaging, String? pendingAt, String? dispatchedAt, String? status}) {
    return OrderItems(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      dispatchedQuantity: dispatchedQuantity ?? this.dispatchedQuantity,
      marking: marking ?? this.marking,
      packaging: packaging ?? this.packaging,
      pendingAt: pendingAt ?? this.pendingAt,
      dispatchedAt: dispatchedAt ?? this.dispatchedAt,
      status: status ?? this.status,
    );
  }
}

class OrderData {
  final int? id;
  final String? orderNumber;
  final String? customerName;
  final String? note;
  final bool? isUrgent;
  final List<OrderStatus>? orderStatus;
  final OrderStatusUpdatedBy? orderStatusUpdatedBy;
  final List<OrderItems>? orderItems;
  final int? orderItemsCount;
  final int? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const OrderData({
    this.id,
    this.orderNumber,
    this.customerName,
    this.note,
    this.isUrgent,
    this.orderStatus,
    this.orderStatusUpdatedBy,
    this.orderItems,
    this.orderItemsCount,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      id: json['id'] as int?,
      orderNumber: json['order_number'] as String?,
      customerName: json['customer_name'] as String?,
      note: json['note'] as String?,
      isUrgent: json['is_urgent'] as bool?,
      orderStatus: json['order_statuses'] != null ? (json['order_statuses'] as List).map((e) => OrderStatus.fromJson(e as Map<String, dynamic>)).toList() : null,
      orderStatusUpdatedBy: json['order_status_updated_by'] != null ? OrderStatusUpdatedBy.fromJson(json['order_status_updated_by'] as Map<String, dynamic>) : null,
      orderItems: json['order_items'] != null ? (json['order_items'] as List).map((e) => OrderItems.fromJson(e as Map<String, dynamic>)).toList() : null,
      orderItemsCount: json['order_items_count'] as int?,
      createdBy: json['created_by'] as int?,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at'] as String) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_number': orderNumber,
      'customer_name': customerName,
      'note': note,
      'is_urgent': isUrgent,
      'order_status': orderStatus?.map((e) => e.toJson()).toList(),
      'order_status_updated_by': orderStatusUpdatedBy?.toJson(),
      'order_items': orderItems?.map((e) => e.toJson()).toList(),
      'order_items_count': orderItemsCount,
      'created_by': createdBy,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  OrderData copyWith({
    int? id,
    String? orderNumber,
    String? customerName,
    String? note,
    bool? isUrgent,
    List<OrderStatus>? orderStatus,
    OrderStatusUpdatedBy? orderStatusUpdatedBy,
    List<OrderItems>? orderItems,
    int? orderItemsCount,
    int? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OrderData(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      customerName: customerName ?? this.customerName,
      note: note ?? this.note,
      isUrgent: isUrgent ?? this.isUrgent,
      orderStatus: orderStatus ?? this.orderStatus,
      orderStatusUpdatedBy: orderStatusUpdatedBy ?? this.orderStatusUpdatedBy,
      orderItems: orderItems ?? this.orderItems,
      orderItemsCount: orderItemsCount ?? this.orderItemsCount,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class OrderResponseNew {
  final String? message;
  final OrderData? orderData;

  const OrderResponseNew({this.message, this.orderData});

  factory OrderResponseNew.fromJson(Map<String, dynamic> json) {
    return OrderResponseNew(message: json['message'] as String?, orderData: json['data'] != null ? OrderData.fromJson(json['data'] as Map<String, dynamic>) : null);
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'order_data': orderData?.toJson()};
  }

  OrderResponseNew copyWith({String? message, OrderData? orderData}) {
    return OrderResponseNew(message: message ?? this.message, orderData: orderData ?? this.orderData);
  }
}
