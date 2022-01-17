import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_eyes/app/modules/products/products_store.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  final String title;
  const ProductsPage({Key? key, this.title = 'ProductsPage'}) : super(key: key);
  @override
  ProductsPageState createState() => ProductsPageState();
}

class ProductsPageState extends State<ProductsPage> {
  final ProductsStore store = Modular.get();

  @override
  void didChangeDependencies() {
    store.products(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Observer(builder: (context) {
        return RefreshIndicator(
          onRefresh: () async {
            await store.products(context);
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              Text(
                store.response,
              ),
            ],
          ),
        );
      }),
    );
  }
}
