import 'package:dio/dio.dart';

enum RequestWay {
  get,
  post,
  put,
}

class HttpUtils {
  static Dio _dio;

  static sendRequest(
    String url, {
    Map<String, dynamic> params,
    RequestWay way = RequestWay.post,
  }) async {
    _dio = Dio();
    _dio.options.baseUrl = "http://jd.itying.com/api";
    _dio.options.connectTimeout = 10000;
    _dio.options.receiveTimeout = 5000;
    Response response;
    try {
      if (way == RequestWay.get) {
        response = await _dio.get(url, queryParameters: params);
      } else if (way == RequestWay.post) {
        response = await _dio.post(url, data: params);
      }
      if (response.statusCode >= 200 && response.statusCode <= 400) {
        return response.data;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        print(e.request);
        print(e.message);
      }
    } finally {}
  }
}
