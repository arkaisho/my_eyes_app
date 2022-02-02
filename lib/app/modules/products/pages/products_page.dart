import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_eyes/app/modules/products/components/product_tile.dart';
import 'package:my_eyes/app/modules/products/products_store.dart';
import 'package:flutter/material.dart';
import 'package:my_eyes/app/shareds/custom_bottom_navigation_bar.dart';
import 'package:my_eyes/app/shareds/custom_colors.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);
  @override
  ProductsPageState createState() => ProductsPageState();
}

class ProductsPageState extends State<ProductsPage> {
  final ProductsStore store = Modular.get();

  int currentIndex = 0;

  @override
  void didChangeDependencies() {
    store.products(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Meus produtos",
          style: GoogleFonts.raleway(
            fontWeight: FontWeight.bold,
            color: CustomColors.mainBlue,
            fontSize: 20,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: CustomColors.mainBlue,
          onPressed: () {
            Modular.to.pushNamed("product_creation");
          },
        ),
      ),
      body: Observer(builder: (context) {
        return RefreshIndicator(
          onRefresh: () async {
            await store.products(context);
          },
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: store.productList
                      .map((product) => ProductTile(product: product))
                      .toList(),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: CustomBottomNavigationBar(),
              ),
            ],
          ),
        );
      }),
    );
  }
}
