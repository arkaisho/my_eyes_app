import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:my_eyes/app/models/product.dart';
import 'package:my_eyes/app/modules/products/datasources/products_api.dart';
import 'package:my_eyes/app/utils/authentication.dart';

part 'products_store.g.dart';

class ProductsStore = _ProductsStoreBase with _$ProductsStore;

abstract class _ProductsStoreBase with Store {
  final ProductsApi api;
  _ProductsStoreBase(this.api);

  @observable
  ObservableList<Product> productList = ObservableList.of([]);

  @action
  Future products(BuildContext context) async {
    try {
      var response = await api.products();

      if (response.data.runtimeType == List) {
        this.productList = ObservableList.of(
          ((response.data as List<dynamic>)
              .map((product) => Product.fromJson(product))).toList(),
        );
      }
    } catch (e) {
      print(e);
      if (e.runtimeType == DioError) {
        if ((e as DioError).response!.statusCode == 401) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Credenciais inválidas."),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erro ao carregar lista de produtos."),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
