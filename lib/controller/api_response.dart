class ApiResponse {
  final String? message;

  const ApiResponse({this.message});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(message: json['message'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}
