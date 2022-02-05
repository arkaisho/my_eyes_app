import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:my_eyes/app/models/product.dart';
import 'package:my_eyes/app/modules/authentication/authentication_store.dart';
import 'package:my_eyes/app/modules/products/datasources/products_api.dart';
import 'package:my_eyes/app/utils/error_messager.dart';

part 'products_store.g.dart';

class ProductsStore = _ProductsStoreBase with _$ProductsStore;

abstract class _ProductsStoreBase with Store {
  final ProductsApi api;
  final AuthenticationStore authenticationStore = Modular.get();

  _ProductsStoreBase(this.api);

  @observable
  Product product = Product();

  @observable
  bool loading = false;

  @observable
  ObservableList<Product> productList = ObservableList.of([]);

  @action
  Future setProduct(Product product) async => this.product = product;

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
      showMessageError(
        context: context,
        error: e,
        defaultActionText: "Error ao carregar lista de produtos",
      );
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
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      showMessageError(
        context: context,
        error: e,
        defaultActionText: "Error ao cadastrar produto",
      );
    }
    loading = false;
  }

  // create a action to update a product
  @action
  Future updateProduct(
    BuildContext context, {
    required String name,
    required String slug,
    required String price,
    required String description,
    required int id,
  }) async {
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
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      showMessageError(
        context: context,
        error: e,
        defaultActionText: "Error ao atualizar produto",
      );
    }
    loading = false;
  }

  @action
  Future deleteProduct(BuildContext context, {required String slug}) async {
    loading = true;
    try {
      await api.deleteProduct(slug);
      this.productList.removeWhere((product) => product.slug == slug);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Produto removido com sucesso."),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      showMessageError(
        context: context,
        error: e,
        defaultActionText: "Error ao remover produto",
      );
    }
    loading = false;
  }

  // create a action to download the qr code pdf
  @action
  Future downloadQrCode(BuildContext context, {required String slug}) async {
    loading = true;
    try {
      var response = await api.downloadQrCode(slug);
      final bytes = response.data;
      // String dir = (await getApplicationDocumentsDirectory()).path;
      // File file = new File('$dir/$filename');
      // await file.writeAsBytes(bytes);

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Qr code baixado com sucesso."),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      showMessageError(
        context: context,
        error: e,
        defaultActionText: "Error ao baixar QR-Code",
      );
    }
    loading = false;
  }
}
