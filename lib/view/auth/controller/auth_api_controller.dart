import 'package:blueberry/controller/api_response.dart';
import 'package:blueberry/main.dart';
import 'package:blueberry/network/api_client.dart';
import 'package:blueberry/view/auth/model/login_response.dart';

class AuthApiController {
  static Future<LoginResponse> loginApi({required Map<String, dynamic> request}) async {
    LoginResponse res = LoginResponse.fromJson(await handleResponse(await buildHttpResponse(AuthApiEndpoints.loginApiUrl, request: request, method: HttpMethodType.POST)));
    return res;
  }

  static Future<LoginResponse> getUserDetailApi({bool isSaveDetail = false, bool isCheckToken = false}) async {
    LoginResponse res = LoginResponse.fromJson(await handleResponse(await buildHttpResponse(AuthApiEndpoints.getUserUrl + "/${userStore.employeeData!.id.validate()}", method: HttpMethodType.GET)));
    return res;
  }

  static Future<LoginResponse> forgotPasswordApi({required Map<String, dynamic> request}) async {
    LoginResponse res = LoginResponse.fromJson(await handleResponse(await buildHttpResponse(AuthApiEndpoints.forgotPasswordUrl, request: request, method: HttpMethodType.POST)));
    return res;
  }

  static Future<LoginResponse> resetPasswordApi({required Map<String, dynamic> request}) async {
    LoginResponse res = LoginResponse.fromJson(await handleResponse(await buildHttpResponse(AuthApiEndpoints.resetPasswordUrl, request: request, method: HttpMethodType.POST)));
    return res;
  }

  static Future<LoginResponse> changePasswordApi({required Map<String, dynamic> request}) async {
    LoginResponse res = LoginResponse.fromJson(await handleResponse(await buildHttpResponse(AuthApiEndpoints.changePasswordUrl, request: request, method: HttpMethodType.POST)));
    return res;
  }

  static Future<LoginResponse> onSignUpApi({required Map<String, dynamic> request}) async {
    LoginResponse res = LoginResponse.fromJson(await handleResponse(await buildHttpResponse(AuthApiEndpoints.signUpUrl, request: request, method: HttpMethodType.POST)));
    return res;
  }

  static Future<ApiResponse> updateTokenApi({required Map<String, dynamic> request}) async {
    ApiResponse res = ApiResponse.fromJson(await handleResponse(await buildHttpResponse(AuthApiEndpoints.updateDeviceToken, request: request, method: HttpMethodType.POST)));
    return res;
  }
}
