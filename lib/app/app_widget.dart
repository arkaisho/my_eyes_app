import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_eyes/app/shareds/custom_colors.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My eyes',
      theme: ThemeData(primarySwatch: CustomColors.materialPrimaryColor),
    ).modular();
  }
}
