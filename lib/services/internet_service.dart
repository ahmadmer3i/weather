import 'package:dio/dio.dart';

class InternetServices {
  static Future<Response> dioData({
    required var dataMap,
    required var url,
    required var responseData,
  }) async {
    var dio = Dio();
    return await dio.get(url, queryParameters: dataMap);
  }
}
