import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:my_eyes/app/shareds/circular_button.dart';
import 'package:my_eyes/app/shareds/custom_bottom_navigation_bar.dart';
import 'package:my_eyes/app/shareds/custom_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QrCodePage extends StatefulWidget {
  final String title;
  const QrCodePage({Key? key, this.title = 'ProfilePage'}) : super(key: key);
  @override
  QrCodePageState createState() => QrCodePageState();
}

class QrCodePageState extends State<QrCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: CustomColors.mainBlue,
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularButton(
                    onTap: () {},
                    text: "Iniciar",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileOptionTile extends StatelessWidget {
  final Function() onTap;
  final String text;
  final Widget icon;
  const ProfileOptionTile({
    required this.onTap,
    required this.icon,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: GoogleFonts.raleway(
                color: CustomColors.mainBlue,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            icon
          ],
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.black.withOpacity(.3),
            ),
          ),
        ),
      ),
    );
  }
}
