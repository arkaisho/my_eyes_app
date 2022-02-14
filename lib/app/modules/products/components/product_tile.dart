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
        vertical: 5,
      ),
      child: Material(
        color: Colors.transparent,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Ink(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: InkWell(
            onTap: () {
              store.setProduct(widget.product);
              Modular.to.pushNamed(
                'product_details',
              );
            },
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // add buttons to view and delete
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                store.setProduct(widget.product);
                                Modular.to.pushNamed(
                                  'product_edition',
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                final store = Modular.get<ProductsStore>();
                                store.deleteProduct(context,
                                    slug: '${widget.product.slug}');
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
