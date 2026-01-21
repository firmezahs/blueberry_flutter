class ResponseData {
  final int? id;
  final String? orderNumber;
  final String? customerName;
  final String? note;
  final bool? isUrgent;
  final int? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ResponseData({this.id, this.orderNumber, this.customerName, this.note, this.isUrgent, this.createdBy, this.createdAt, this.updatedAt});

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      id: json['id'] as int?,
      orderNumber: json['order_number'] as String?,
      customerName: json['customer_name'] as String?,
      note: json['note'] as String?,
      isUrgent: json['is_urgent'] as bool?,
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
      'created_by': createdBy,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  ResponseData copyWith({int? id, String? orderNumber, String? customerName, String? note, bool? isUrgent, int? createdBy, DateTime? createdAt, DateTime? updatedAt}) {
    return ResponseData(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      customerName: customerName ?? this.customerName,
      note: note ?? this.note,
      isUrgent: isUrgent ?? this.isUrgent,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class NotificationData {
  final int? id;
  final String? title;
  final String? message;
  final String? notificationType;
  final int? isRead;
  final ResponseData? responseData;
  final DateTime? createdAt;

  const NotificationData({this.id, this.title, this.message, this.notificationType, this.isRead, this.responseData, this.createdAt});

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      id: json['id'] as int?,
      title: json['title'] as String?,
      message: json['message'] as String?,
      notificationType: json['notification_type'] as String?,
      isRead: json['is_read'] as int?,
      responseData: json['response_data'] != null ? ResponseData.fromJson(json['response_data'] as Map<String, dynamic>) : null,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'notification_type': notificationType,
      'is_read': isRead,
      'response_data': responseData?.toJson(),
      'created_at': createdAt?.toIso8601String(),
    };
  }

  NotificationData copyWith({int? id, String? title, String? message, String? notificationType, int? isRead, ResponseData? responseData, DateTime? createdAt}) {
    return NotificationData(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      notificationType: notificationType ?? this.notificationType,
      isRead: isRead ?? this.isRead,
      responseData: responseData ?? this.responseData,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class NotificationResponse {
  final String? message;
  final int? total;
  final int? totalUnreadRecords;
  final List<NotificationData>? data;

  const NotificationResponse({this.message, this.total, this.totalUnreadRecords, this.data});

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      message: json['message'] as String?,
      total: json['total'] as int?,
      totalUnreadRecords: json['totalUnreadRecords'] as int?,
      data: json['data'] != null ? (json['data'] as List).map((e) => NotificationData.fromJson(e as Map<String, dynamic>)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'total': total, 'totalUnreadRecords': totalUnreadRecords, 'data': data?.map((e) => e.toJson()).toList()};
  }

  NotificationResponse copyWith({String? message, int? total, int? totalUnreadRecords, List<NotificationData>? data}) {
    return NotificationResponse(message: message ?? this.message, total: total ?? this.total, totalUnreadRecords: totalUnreadRecords ?? this.totalUnreadRecords, data: data ?? this.data);
  }
}
