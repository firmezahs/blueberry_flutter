class AppConfig {
  static String url = "https://dev-blueberry.firmeza.co.in";
  static String baseUrl = "$url/api/v1/";
  static String imageUrl = "$url/storage/";
  static String tokenStream = 'tokenStream';
  static String googleMapKey = "";
  static String googleFonts = "DM Sans";
  static int allowedWorkRange = 3000;
}

class SharePreferencesKey {
  static String accessToken = "accessToken";
  static String loggedIn = "loggedIn";
  static String employeeData = "employeeData";
  static String isRemember = "isRemember";
  static String firebaseToken = "firebaseToken";
  static String packagingData = "packagingData";
  static String orderStatus = "orderStatus";
  static String fcmToken = "fcmToken";
}

class AuthApiEndpoints {
  static const loginApiUrl = "auth";
  static const logoutApiUrl = "logout";
  static const signUpUrl = "register";
  static const forgotPasswordUrl = "forgot-password";
  static const resetPasswordUrl = "reset-password";
  static const changePasswordUrl = "change-password";
  static const getUserUrl = "get-profile";
  static const updateUserUrl = "update-profile";

  static const updateProfileUrl = "update-profile-image-verification";
  static const verifyOtp = "verify-otp";
  static const deleteAccount = "engineer/delete-account";
  static const sendEmailOtp = "resend-otp";

  static const getProfileStatus = "engineer/profile-status";
  static const timezone = "timezones";
  static const updateDeviceToken = "update-device-token";
}

class OrderApiEndpoints {
  static const dashboard = "dashboard";
  static const notification = "notification/all";
  static const productPackaging = "product/packaging";
  static const createOrder = "order/create";
  static const updateOrder = "order/update";
  static const orderListing = "order/list";
  static const orderDetail = "order/detail";
  static const orderStatus = "order/status";
  static const updateOrderStatus = "order/update-status";
}
