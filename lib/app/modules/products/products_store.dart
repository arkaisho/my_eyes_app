import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:mobx/mobx.dart';
import 'package:my_eyes/app/models/product.dart';
import 'package:my_eyes/app/modules/authentication/authentication_store.dart';
import 'package:my_eyes/app/modules/products/datasources/products_api.dart';
import 'package:my_eyes/app/utils/error_messager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

part 'products_store.g.dart';

class ProductsStore = _ProductsStoreBase with _$ProductsStore;

abstract class _ProductsStoreBase with Store {
  final ProductsApi api;
  final AuthenticationStore authenticationStore = Modular.get();

  FlutterTts flutterTts = FlutterTts();

  _ProductsStoreBase(this.api) {
    flutterTts.awaitSpeakCompletion(true);
    flutterTts.setLanguage("pt-BR");
  }

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
  Future downloadQrCode(
    BuildContext context, {
    required Uint8List bytes,
  }) async {
    loading = true;
    try {
      String filePath =
          "${(await getTemporaryDirectory()).path}/qr_code${DateTime.now().millisecondsSinceEpoch}.jpg";

      File savedFile = File(filePath);
      savedFile.writeAsBytesSync(bytes);

      await Share.shareFiles(
        [savedFile.path],
        text: "Qr Code do " + product.name.toString(),
      );

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
        defaultActionText: e.toString(),
      );
    }
    loading = false;
  }

  Future speak(String text) async {
    await flutterTts.stop();
    await flutterTts.speak(text);
  }
}
