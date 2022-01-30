import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_eyes/app/models/product.dart';
import 'package:my_eyes/app/modules/products/pages/products_page.dart';
import 'package:my_eyes/app/shareds/custom_colors.dart';

import '../products_store.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({
    required this.product,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 10,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name.toString(),
                    style: GoogleFonts.raleway(
                      fontWeight: FontWeight.bold,
                      color: CustomColors.mainBlack,
                      fontSize: 14,
                    ),
                  ),
                  Container(height: 5),
                  Text(
                    product.description.toString(),
                    style: GoogleFonts.raleway(
                      color: CustomColors.mainBlack.withOpacity(.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Modular.to.pushNamed(
                'product_details',
                arguments: {'product': product},
              );
            },
            child: CircleAvatar(
              backgroundColor: CustomColors.mainBlue,
              radius: 15,
              child: Icon(
                Icons.remove_red_eye,
                size: 15,
                color: Colors.white,
              ),
            ),
          ),
          Container(width: 5),
          GestureDetector(
            onTap: () {
              Modular.to.pushNamed(
                'product_edition',
                arguments: {'product': product},
              );
            },
            child: CircleAvatar(
              backgroundColor: CustomColors.mainBlue,
              radius: 15,
              child: Icon(
                Icons.edit,
                size: 15,
                color: Colors.white,
              ),
            ),
          ),
          Container(width: 5),
          GestureDetector(
            onTap: () {
              final store = Modular.get<ProductsStore>();
              store.deleteProduct(context, slug: '${product.slug}');
            },
            child: CircleAvatar(
              backgroundColor: CustomColors.mainBlue,
              radius: 15,
              child: Icon(
                Icons.delete,
                size: 15,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
