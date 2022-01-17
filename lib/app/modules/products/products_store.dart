import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:my_eyes/app/modules/products/datasources/products_api.dart';
import 'package:my_eyes/app/utils/authentication.dart';

part 'products_store.g.dart';

class ProductsStore = _ProductsStoreBase with _$ProductsStore;

abstract class _ProductsStoreBase with Store {
  final ProductsApi api;
  _ProductsStoreBase(this.api);

  @observable
  String response = '';

  @action
  Future products(BuildContext context) async {
    try {
      print("TOKEN: " + (await Authentication.getToken()).toString());
      var response = await api.products();
      this.response = response.toString();
    } catch (e) {
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
