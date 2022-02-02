import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_eyes/app/models/product.dart';
import 'package:my_eyes/app/shareds/custom_colors.dart';

import '../products_store.dart';

class ProductTile extends StatefulWidget {
  final Product product;

  const ProductTile({
    required this.product,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  final ProductsStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name.toString(),
                    style: GoogleFonts.raleway(
                      fontWeight: FontWeight.bold,
                      color: CustomColors.mainBlack,
                      fontSize: 16,
                    ),
                  ),
                  Container(height: 5),
                  Text(
                    widget.product.description.toString(),
                    style: GoogleFonts.raleway(
                      color: CustomColors.mainBlack.withOpacity(.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              store.setProduct(widget.product);
              Modular.to.pushNamed(
                'product_details',
              );
            },
            child: CircleAvatar(
              backgroundColor: CustomColors.mainBlue,
              radius: 20,
              child: Icon(
                Icons.remove_red_eye,
                size: 15,
                color: Colors.white,
              ),
            ),
          ),
          Container(width: 10),
          GestureDetector(
            onTap: () {
              store.setProduct(widget.product);
              Modular.to.pushNamed(
                'product_edition',
              );
            },
            child: CircleAvatar(
              backgroundColor: CustomColors.mainBlue,
              radius: 20,
              child: Icon(
                Icons.edit,
                size: 15,
                color: Colors.white,
              ),
            ),
          ),
          Container(width: 10),
          GestureDetector(
            onTap: () {
              final store = Modular.get<ProductsStore>();
              store.deleteProduct(context, slug: '${widget.product.slug}');
            },
            child: CircleAvatar(
              backgroundColor: CustomColors.mainBlue,
              radius: 20,
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
