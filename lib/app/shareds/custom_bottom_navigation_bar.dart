import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_eyes/app/shareds/custom_colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              print("object");
              Modular.to.pushReplacementNamed("/products");
            },
            child: Icon(
              Icons.list,
              color: CustomColors.mainBlue,
            ),
          ),
          IconButton(
            onPressed: () {
              Modular.to.pushReplacementNamed("/qr_code");
            },
            icon: Icon(
              Icons.qr_code_outlined,
              color: CustomColors.mainBlue,
            ),
          ),
          IconButton(
            onPressed: () {
              Modular.to.pushReplacementNamed("/profile");
            },
            icon: Icon(
              Icons.person_outline,
              color: CustomColors.mainBlue,
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
    );
  }
}
