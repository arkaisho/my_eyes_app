import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_eyes/app/modules/products/products_store.dart';
import 'package:flutter/material.dart';
import 'package:my_eyes/app/shareds/circular_button.dart';
import 'package:my_eyes/app/shareds/custom_colors.dart';
import 'package:my_eyes/app/shareds/custom_text_form_field.dart';

class ProductEditionPage extends StatefulWidget {
  const ProductEditionPage({Key? key}) : super(key: key);
  @override
  ProductEditionPageState createState() => ProductEditionPageState();
}

class ProductEditionPageState extends State<ProductEditionPage> {
  final ProductsStore store = Modular.get();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Edição de produto",
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
      body: Observer(builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(height: 50),
                  CustomTextFormField(
                    controller: nameController,
                    hintText: "Nome do produto",
                    prefixIcon: Icon(
                      Icons.text_fields,
                      color: CustomColors.mainBlue,
                    ),
                  ),
                  CustomTextFormField(
                    controller: priceController,
                    hintText: "Preço",
                    prefixIcon: Icon(
                      Icons.attach_money,
                      color: CustomColors.mainBlue,
                    ),
                  ),
                  CustomTextFormField(
                    controller: descriptionController,
                    hintText: "Descrição",
                    prefixIcon: Icon(
                      Icons.list,
                      color: CustomColors.mainBlue,
                    ),
                  ),
                  CustomTextFormField(
                    controller: categoryController,
                    hintText: "Categoria",
                    prefixIcon: Icon(
                      Icons.category,
                      color: CustomColors.mainBlue,
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 30,
                left: 30,
                right: 30,
                child: Row(
                  children: [
                    Expanded(
                      child: CircularButton(
                        text: "Salvar",
                        onTap: () async {},
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
