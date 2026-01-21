import 'package:blueberry/view/auth/model/employee_response.dart';

class LoginResponse {
  final String? message;
  final EmployeeResponse? loginData;

  const LoginResponse({
    this.message,
    this.loginData,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'] as String?,
      loginData: json['data'] != null ? EmployeeResponse.fromJson(json['data'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': loginData?.toJson(),
    };
  }

  LoginResponse copyWith({
    String? message,
    EmployeeResponse? loginData,
  }) {
    return LoginResponse(
      message: message ?? this.message,
      loginData: loginData ?? this.loginData,
    );
  }
}
