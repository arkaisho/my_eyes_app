import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_eyes/app/shareds/custom_colors.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final Icon? prefixIcon;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.prefixIcon,
    this.validator,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: widget.controller,
        onEditingComplete: () {
          FocusScope.of(context).nextFocus();
        },
        obscureText: widget.isPassword && hidePassword,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: GoogleFonts.raleway(
            color: CustomColors.mainBlack.withOpacity(.5),
            fontSize: 14,
          ),
          focusColor: CustomColors.mainBlue,
          hoverColor: CustomColors.mainBlue,
          fillColor: CustomColors.mainBlue,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    hidePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                )
              : null,
          prefixIcon: widget.isPassword
              ? Icon(
                  Icons.lock,
                  color: CustomColors.mainBlue,
                )
              : widget.prefixIcon,
        ),
        cursorColor: CustomColors.mainBlue,
        validator: widget.validator != null
            ? (value) {
                return widget.validator!(value);
              }
            : (value) {},
      ),
    );
  }
}
