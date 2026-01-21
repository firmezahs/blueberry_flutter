class PackagingResponse {
  final String? message;
  final List<String>? data;

  const PackagingResponse({this.message, this.data});

  factory PackagingResponse.fromJson(Map<String, dynamic> json) {
    return PackagingResponse(message: json['message'] as String?, data: json['data'] != null ? List<String>.from(json['data'] as List) : null);
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data};
  }

  PackagingResponse copyWith({String? message, List<String>? data}) {
    return PackagingResponse(message: message ?? this.message, data: data ?? this.data);
  }
}

class OrderStatus {
  final String? message;
  final List<String>? data;

  const OrderStatus({this.message, this.data});

  factory OrderStatus.fromJson(Map<String, dynamic> json) {
    return OrderStatus(message: json['message'] as String?, data: json['data'] != null ? List<String>.from(json['data'] as List) : null);
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data};
  }

  PackagingResponse copyWith({String? message, List<String>? data}) {
    return PackagingResponse(message: message ?? this.message, data: data ?? this.data);
  }
}
