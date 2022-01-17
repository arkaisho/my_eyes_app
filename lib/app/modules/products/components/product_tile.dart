import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_eyes/app/shareds/custom_colors.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
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
                    "Product name",
                    style: GoogleFonts.raleway(
                      fontWeight: FontWeight.bold,
                      color: CustomColors.mainBlack,
                      fontSize: 14,
                    ),
                  ),
                  Container(height: 5),
                  Text(
                    "Product description",
                    style: GoogleFonts.raleway(
                      color: CustomColors.mainBlack.withOpacity(.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor: CustomColors.mainBlue,
            radius: 15,
            child: Icon(
              Icons.edit,
              size: 15,
              color: Colors.white,
            ),
          ),
          Container(width: 10),
          CircleAvatar(
            backgroundColor: CustomColors.mainBlue,
            radius: 15,
            child: Icon(
              Icons.delete,
              size: 15,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
