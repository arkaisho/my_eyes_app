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
  final formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    nameController.text = store.product.name.toString();
    priceController.text = store.product.price.toString();
    descriptionController.text = store.product.description.toString();
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
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(height: 50),
                    CustomTextFormField(
                      controller: nameController,
                      hintText: "Nome do produto",
                      prefixIcon: Icon(
                        Icons.text_fields,
                        color: CustomColors.mainBlue,
                      ),
                      validator: (value) {
                        if (value!.isEmpty)
                          return 'Por favor, preencha o nome do produto';
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      controller: priceController,
                      hintText: "Preço",
                      prefixIcon: Icon(
                        Icons.attach_money,
                        color: CustomColors.mainBlue,
                      ),
                      validator: (value) {
                        if (value!.isEmpty)
                          return 'Por favor, preencha o preço do produto';
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      controller: descriptionController,
                      hintText: "Descrição",
                      prefixIcon: Icon(
                        Icons.list,
                        color: CustomColors.mainBlue,
                      ),
                      validator: (value) {
                        if (value!.isEmpty)
                          return 'Por favor, preencha a descrição do produto';
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    store.loading
                        ? CircularProgressIndicator()
                        : Expanded(
                            child: CircularButton(
                              text: "Salvar",
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  await store.updateProduct(
                                    context,
                                    id: store.product.id!,
                                    slug: store.product.slug.toString(),
                                    name: nameController.text,
                                    price: priceController.text,
                                    description: descriptionController.text,
                                  );
                                }
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
