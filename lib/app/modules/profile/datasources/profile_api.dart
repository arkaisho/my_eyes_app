import 'package:dio/dio.dart';
import 'package:my_eyes/app/utils/dio_config.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

part 'profile_api.g.dart';

@RestApi()
abstract class ProfileApi {
  factory ProfileApi(Dio dio, {String? baseUrl}) = _ProfileApi;

  @GET("/api/v1/users/me")
  @Header(JSON_HEADER)
  Future<HttpResponse> me(@Body() Map<String, dynamic> body);
}
