import 'dart:convert';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_eyes/app/modules/products/products_store.dart';
import 'package:flutter/material.dart';
import 'package:my_eyes/app/shareds/circular_button.dart';
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
    final ProductsStore store = Modular.get();

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Nome:  ",
                    style: GoogleFonts.raleway(
                      fontWeight: FontWeight.bold,
                      color: CustomColors.mainBlue,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "${store.product.name}",
                    style: GoogleFonts.raleway(
                      color: CustomColors.mainBlue,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "Descrição:  ",
                    style: GoogleFonts.raleway(
                      fontWeight: FontWeight.bold,
                      color: CustomColors.mainBlue,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "${store.product.description}",
                    style: GoogleFonts.raleway(
                      color: CustomColors.mainBlue,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "Preço: R\$  ",
                    style: GoogleFonts.raleway(
                      fontWeight: FontWeight.bold,
                      color: CustomColors.mainBlue,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "${store.product.price}",
                    style: GoogleFonts.raleway(
                      color: CustomColors.mainBlue,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Align(
                  alignment: Alignment.center,
                  child: Image.memory(
                    base64Decode(store.product.base_64_qr_code.toString()),
                    height: 250,
                    width: 250,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 80),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CircularButton(
                    onTap: () {
                      store.downloadQrCode(
                        context,
                        slug: store.product.slug.toString(),
                      );
                    },
                    text: "Baixar código QR",
                  ),
                ),
              ),
              Container(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
