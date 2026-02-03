import 'package:blueberry/controller/api_response.dart';
import 'package:blueberry/network/api_client.dart';
import 'package:blueberry/view/orders/model/order_response.dart';
import 'package:blueberry/view/orders/model/packaging_response.dart';

class OrderController {
  static Future<PackagingResponse> productPackingApi() async {
    PackagingResponse res = PackagingResponse.fromJson(await handleResponse(await buildHttpResponse(OrderApiEndpoints.productPackaging, method: HttpMethodType.GET)));
    return res;
  }

  static Future<ApiResponse> saveOrderApi({required Map<String, dynamic> request}) async {
    ApiResponse res = ApiResponse.fromJson(await handleResponse(await buildHttpResponse(OrderApiEndpoints.createOrder, method: HttpMethodType.POST, request: request)));

    return res;
  }

  static Future<ApiResponse> updateOrderApi({required Map<String, dynamic> request, required int id}) async {
    ApiResponse res = ApiResponse.fromJson(await handleResponse(await buildHttpResponse(OrderApiEndpoints.updateOrder + "/$id", method: HttpMethodType.POST, request: request)));

    return res;
  }

  static Future<ApiResponse> updateOrderStatusApi({required Map<String, dynamic> request}) async {
    ApiResponse res = ApiResponse.fromJson(await handleResponse(await buildHttpResponse(OrderApiEndpoints.updateOrderStatus, method: HttpMethodType.POST, request: request)));

    return res;
  }

  static Future<OrderResponse> getOrderListing({String status = 'Pending', int page = 0, int perPage = 10}) async {
    log("e");
    // if (status == "Pending") {
    //   status = "Pending, Partial Dispatched";
    // }
    String parameter = status != "All" ? "?start=$page&rawperpage=$perPage" : "?start=$page&rawperpage=$perPage";
    var json = {};

    if (status != "All") {
      json.putIfAbsent("status", () => status == "Pending" ? "Pending, Partial Dispatched" : status);
    }
    OrderResponse res = OrderResponse.fromJson(await handleResponse(await buildHttpResponse(OrderApiEndpoints.orderListing + parameter, method: HttpMethodType.POST, request: json)));

    return res;
  }

  static Future<OrderData> orderDetail({int orderID = 0}) async {
    String parameter = "/$orderID";
    var respose = await handleResponse(await buildHttpResponse(OrderApiEndpoints.orderDetail + parameter, method: HttpMethodType.GET));
    OrderData res = OrderData.fromJson(respose['data']);
    return res;
  }

  static Future<OrderStatus> orderStatus() async {
    OrderStatus res = OrderStatus.fromJson(await handleResponse(await buildHttpResponse(OrderApiEndpoints.orderStatus, method: HttpMethodType.GET)));

    return res;
  }
}
