import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_eyes/app/shareds/custom_colors.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.raleway(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: CustomColors.mainBlue,
        ),
      ),
    );
  }
}
