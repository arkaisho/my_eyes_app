import 'package:dio/dio.dart';
import 'package:my_eyes/app/utils/dio_config.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

part 'authentication_api.g.dart';

@RestApi()
abstract class AuthenticationApi {
  factory AuthenticationApi(Dio dio, {String? baseUrl}) = _AuthenticationApi;

  @POST("/api/v1/shops")
  @Header(JSON_HEADER)
  Future<HttpResponse> register(@Body() Map<String, dynamic> body);

  @POST("/api/v1/jwt/create/")
  @Header(JSON_HEADER)
  Future<HttpResponse> login(@Body() Map<String, dynamic> body);

  @GET("/api/v1/users/me")
  @Header(JSON_HEADER)
  Future<HttpResponse> me(@Body() Map<String, dynamic> body);

  @POST("/api/v1/users/reset_password/")
  @Header(JSON_HEADER)
  Future<HttpResponse> recoverPassword(@Body() Map<String, dynamic> body);
}
