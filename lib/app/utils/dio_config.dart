import 'package:dio/dio.dart';

import 'authentication.dart';

const JSON_HEADER = "Content-Type:application/json";

const JSON_HEADER_MULTIPART = "Content-Type:multipart/form-data";

class DioConfig {
  static final DioConfig _instance = DioConfig.internal();

  factory DioConfig() => _instance;

  DioConfig.internal();

  Dio _dio = Dio();
  final String _baseUrl = "https://ddm-rest-api.herokuapp.com";

  get dio {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.connectTimeout = 50000;
    _dio.options.receiveTimeout = 30000;
    _dio.interceptors.add(CustomInterceptors());
    return _dio;
  }
}

class CustomInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final auth = await Authentication.authenticated();
    final token = await Authentication.getToken();
    if (auth) options.headers["Authorization"] = "JWT $token";
    options.headers["Accept"] = "application/json";
    return super.onRequest(options, handler);
  }
}
