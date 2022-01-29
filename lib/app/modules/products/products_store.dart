import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:my_eyes/app/models/product.dart';
import 'package:my_eyes/app/modules/authentication/authentication_store.dart';
import 'package:my_eyes/app/modules/products/datasources/products_api.dart';

part 'products_store.g.dart';

class ProductsStore = _ProductsStoreBase with _$ProductsStore;

abstract class _ProductsStoreBase with Store {
  final ProductsApi api;
  final AuthenticationStore authenticationStore = Modular.get();

  _ProductsStoreBase(this.api);

  @observable
  bool loading = false;

  @observable
  ObservableList<Product> productList = ObservableList.of([]);

  @action
  Future products(BuildContext context) async {
    loading = true;
    try {
      var responseMe = await authenticationStore.me();
      if (responseMe['id'] == null) return;

      var responseShop = await api.getShopByUserId(responseMe['id']);

      var response = await api.products(responseShop.response.data['slug']);

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
    loading = false;
  }

  @action
  Future saveProduct(BuildContext context,
      {required String name,
      required String price,
      required String description}) async {
    loading = true;
    try {
      var responseMe = await authenticationStore.me();
      if (responseMe['id'] == null) return;

      var responseShop = await api.getShopByUserId(responseMe['id']);

      var payload = {
        "name": name,
        "price": price,
        "description": description,
        "shop": responseShop.data['id']
      };
      var response = await api.saveProduct(payload);
      this.productList.add(Product.fromJson(response.data));
      Modular.to.pop();
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Produto adicionado com sucesso."),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      if (e.runtimeType == DioError) {
        print((e as DioError).response!);
      } else {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erro ao fazer cadastrar produto."),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    loading = false;
  }

  // create a action to update a product
  @action
  Future updateProduct(BuildContext context,
      {required String name,
      required String slug,
      required String price,
      required String description,
      required int id}) async {
    loading = true;
    try {
      var responseMe = await authenticationStore.me();
      if (responseMe['id'] == null) return;

      var responseShop = await api.getShopByUserId(responseMe['id']);

      var payload = {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "shop": responseShop.data['id']
      };

      var response = await api.updateProduct(slug, payload);
      this.productList.removeWhere((product) => product.id == id);
      this.productList.add(Product.fromJson(response.data));
      Modular.to.pop();
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Produto atualizado com sucesso."),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      if (e.runtimeType == DioError) {
        print((e as DioError).response!);
      } else {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erro ao fazer atualizar produto."),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    loading = false;
  }

  @action
  Future deleteProduct(BuildContext context, {required String slug}) async {
    loading = true;
    try {
      print('deletando');
      print(slug);
      await api.deleteProduct(slug);
      print('deletado');
      this.productList.removeWhere((product) => product.slug == slug);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Produto removido com sucesso."),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      if (e.runtimeType == DioError) {
        print((e as DioError).response!);
      } else {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erro ao remover produto."),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    loading = false;
  }
}
