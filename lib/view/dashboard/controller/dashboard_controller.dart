import 'package:blueberry/main.dart';
import 'package:blueberry/network/api_client.dart';
import 'package:blueberry/view/alerts/model/notification_response.dart';
import 'package:blueberry/view/dashboard/model/dashboard_response.dart';

class DashboardController {
  static Future<DashboardResponse> dashboardApi() async {
    DashboardResponse res = DashboardResponse.fromJson(await handleResponse(await buildHttpResponse(OrderApiEndpoints.dashboard, method: HttpMethodType.GET)));
    dashboardStore.initialDashboardResponse = res;
    return res;
  }

  static Future<NotificationResponse> notificationApi({int page = 0, int perPage = 10}) async {
    NotificationResponse res = NotificationResponse.fromJson(
      await handleResponse(await buildHttpResponse(OrderApiEndpoints.notification + "?start=$page&rawperpage=$perPage", method: HttpMethodType.GET)),
    );
    // dashboardStore.initialDashboardResponse = res;
    return res;
  }
}
