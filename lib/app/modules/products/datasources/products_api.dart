import 'package:dio/dio.dart';
import 'package:my_eyes/app/utils/dio_config.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

part 'products_api.g.dart';

@RestApi()
abstract class ProductsApi {
  factory ProductsApi(Dio dio, {String? baseUrl}) = _ProductsApi;

  @GET("/api/v1/shops/{slug}/products/")
  @Header(JSON_HEADER)
  Future<HttpResponse> products(@Path("slug") String slug);

  @POST("/api/v1/products/save/")
  @Header(JSON_HEADER)
  Future<HttpResponse> saveProduct(@Body() Map<String, dynamic> body);

  @DELETE("/api/v1/products/{slug}/delete/")
  @Header(JSON_HEADER)
  Future<HttpResponse> deleteProduct(@Path("slug") String slug);

  @GET("/api/v1/shops/user/{id}/")
  @Header(JSON_HEADER)
  Future<HttpResponse> getShopByUserId(@Path() int id);
}
