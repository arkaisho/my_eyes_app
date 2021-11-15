import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'home_api.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class HomeApi {
  factory HomeApi(Dio dio, {String baseUrl}) = _HomeApi;

  @GET("/todos/1")
  Future<dynamic> getTodos();
}
