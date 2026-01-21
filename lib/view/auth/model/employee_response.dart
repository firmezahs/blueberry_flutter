class EmployeeResponse {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? mobileNumber;
  final String? accessToken;
  final String? role;

  const EmployeeResponse({
    this.id,
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.accessToken,
    this.role,
  });

  factory EmployeeResponse.fromJson(Map<String, dynamic> json) {
    return EmployeeResponse(
      id: json['id'] as int?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      mobileNumber: json['mobile_number'] as String?,
      accessToken: json['access_token'] as String?,
      role: json['role'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'mobile_number': mobileNumber,
      'access_token': accessToken,
      'role': role,
    };
  }

  EmployeeResponse copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? mobileNumber,
    String? accessToken,
    String? role,
  }) {
    return EmployeeResponse(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      accessToken: accessToken ?? this.accessToken,
      role: role ?? this.role,
    );
  }
}
