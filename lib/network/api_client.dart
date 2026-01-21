import 'dart:convert';
import 'dart:io';

import 'package:blueberry/main.dart';
import 'package:blueberry/utils/config.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';

export 'package:blueberry/utils/config.dart';
export 'package:nb_utils/nb_utils.dart';

Map<String, String> buildHeaderTokens() {
  Map<String, String> header = {HttpHeaders.cacheControlHeader: 'no-cache', 'Access-Control-Allow-Headers': '*', 'Access-Control-Allow-Origin': '*'};

  header.putIfAbsent(HttpHeaders.contentTypeHeader, () => 'application/json; charset=utf-8');
  header.putIfAbsent(HttpHeaders.authorizationHeader, () => 'Bearer ${userStore.accessToken}');
  header.putIfAbsent(HttpHeaders.acceptHeader, () => 'application/json; charset=utf-8');

  // log(jsonEncode(header));
  return header;
}

Uri buildBaseUrl(String endPoint) {
  Uri url = Uri.parse(endPoint);
  if (!endPoint.startsWith('http')) url = Uri.parse('${AppConfig.baseUrl}$endPoint');

  log('URL: ${url.toString()}');

  return url;
}

Future<Response> buildHttpResponse(String endPoint, {HttpMethodType method = HttpMethodType.GET, Map? request, bool isStripePayment = false}) async {
  if (await isNetworkAvailable()) {
    Uri url = buildBaseUrl(endPoint);

    var headers = buildHeaderTokens();

    Response response;

    if (method == HttpMethodType.POST) {
      print("Request: $request");
      response = await http.post(url, body: jsonEncode(request), headers: headers, encoding: null);
    } else if (method == HttpMethodType.DELETE) {
      response = await delete(url, headers: headers);
    } else if (method == HttpMethodType.PUT) {
      print("Request: $request");
      response = await put(url, body: jsonEncode(request), headers: headers);
    } else {
      response = await get(url, headers: headers);
    }

    log('Response $endPoint ($method): ${response.statusCode} ${response.body}');

    return response;
  } else {
    throw errorInternetNotAvailable;
  }
}

Future handleResponse(Response response, [bool? avoidTokenError]) async {
  if (!await isNetworkAvailable()) {
    throw errorInternetNotAvailable;
  }
  if (response.statusCode == 401) {
    final responseBody = jsonDecode(response.body);
    if (responseBody is Map && responseBody['message'] == 'Invalid credentials') {
      throw 'Invalid credentials';
    } else if (!avoidTokenError.validate()) {
      LiveStream().emit(AppConfig.tokenStream, true);
      throw 'Token Expired';
    }
  }
  if (response.statusCode.isSuccessful()) {
    return jsonDecode(response.body);
  } else {
    try {
      var body = jsonDecode(response.body);
      // print("body $body");

      if (body['error'] != null) {
        throw parseHtmlString(body['error']);
      }
      throw parseHtmlString(body['message']);
    } on Exception catch (e) {
      log(e);
      throw errorSomethingWentWrong;
    }
  }
}

Future<MultipartRequest> getMultiPartRequest(String endPoint, {String? baseUrl}) async {
  String url = '${baseUrl ?? buildBaseUrl(endPoint).toString()}';
  return MultipartRequest('POST', Uri.parse(url));
}

Future<void> sendMultiPartRequest(MultipartRequest multiPartRequest, {Function(dynamic)? onSuccess, Function(dynamic)? onError, bool showSomethingWentWrong = true}) async {
  http.Response response = await http.Response.fromStream(await multiPartRequest.send());
  print("Result: ${response.statusCode}");
  print("error: ${response.body}");

  if (response.statusCode.isSuccessful()) {
    onSuccess?.call(response.body);
  } else {
    onError?.call(showSomethingWentWrong ? errorSomethingWentWrong : jsonDecode(response.body)['message']);
  }
}

/// Downloads a file from the given `url` and saves it to the specified `filePath`.
Future<File> downloadFile(String url, String filePath) async {
  try {
    if (await isNetworkAvailable()) {
      var headers = buildHeaderTokens(); // Get headers from your existing code.
      var uri = buildBaseUrl(url); // Construct the URL using your existing function.

      http.Response response = await http.get(uri, headers: headers);

      if (response.statusCode.isSuccessful()) {
        File file = File(filePath);

        // Write the file content to the file.
        await file.writeAsBytes(response.bodyBytes);

        log('File downloaded successfully: $filePath');
        return file;
      } else {
        log('Failed to download file. Status: ${response.statusCode}');
        throw Exception('Failed to download file. Status: ${response.statusCode}');
      }
    } else {
      throw errorInternetNotAvailable;
    }
  } catch (e) {
    log('Error downloading file: $e');
    rethrow;
  }
}

String parseHtmlString(String? htmlString) {
  return parse(parse(htmlString).body!.text).documentElement!.text;
}
