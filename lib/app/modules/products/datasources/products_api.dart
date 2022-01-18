import 'package:dio/dio.dart';
import 'package:my_eyes/app/utils/dio_config.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

part 'products_api.g.dart';

@RestApi()
abstract class ProductsApi {
  factory ProductsApi(Dio dio, {String? baseUrl}) = _ProductsApi;

  @GET("/api/v1/products/")
  @Header(JSON_HEADER)
  Future<HttpResponse> products();
}
