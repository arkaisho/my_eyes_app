import 'dart:convert';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_eyes/app/modules/products/products_store.dart';
import 'package:flutter/material.dart';
import 'package:my_eyes/app/shareds/custom_colors.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  ProductDetailsPageState createState() => ProductDetailsPageState();
}

class ProductDetailsPageState extends State<ProductDetailsPage> {
  final ProductsStore store = Modular.get();

  int currentIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    var product = arguments['product'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Detalhes do produto",
          style: GoogleFonts.raleway(
            fontWeight: FontWeight.bold,
            color: CustomColors.mainBlue,
            fontSize: 20,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Modular.to.pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: CustomColors.mainBlue,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted), title: Container()),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Container()),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nome: ${product.name}",
                style: GoogleFonts.raleway(
                  fontWeight: FontWeight.bold,
                  color: CustomColors.mainBlue,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Descrição: ${product.description}",
                style: GoogleFonts.raleway(
                  fontWeight: FontWeight.bold,
                  color: CustomColors.mainBlue,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Preço: R\$ ${product.price}",
                style: GoogleFonts.raleway(
                  fontWeight: FontWeight.bold,
                  color: CustomColors.mainBlue,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          // Create a center-aligned image from base64 present in product.base_64_qr_code
          // the image must be resized to fit the screen with a padding top 50
          Padding(
            padding: EdgeInsets.only(top: 110),
            child: Align(
                alignment: Alignment.center,
                child: Image.memory(
                  base64Decode(product.base_64_qr_code),
                  height: 250,
                  width: 250,
                )),
          ),
          // create a button to download the qr code
          // the button must be positioned at the bottom of the screen with a padding bottom 50
          Padding(
            padding: EdgeInsets.only(top: 80),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                onPressed: () {
                  store.downloadQrCode(context, slug: product.slug);
                },
                child: Text(
                  "Baixar código QR",
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.bold,
                    color: CustomColors.mainBlue,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
