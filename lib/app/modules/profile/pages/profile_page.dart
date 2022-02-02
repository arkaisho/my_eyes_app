import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_eyes/app/modules/profile/profile_store.dart';
import 'package:flutter/material.dart';
import 'package:my_eyes/app/shareds/custom_bottom_navigation_bar.dart';
import 'package:my_eyes/app/shareds/custom_colors.dart';
import 'package:my_eyes/app/utils/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final String title;
  const ProfilePage({Key? key, this.title = 'ProfilePage'}) : super(key: key);
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final ProfileStore store = Modular.get();
  String name = "...";

  @override
  void initState() {
    store.me().then((response) {
      setState(() {
        this.name = response['username'].toString();
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Perfil",
          style: GoogleFonts.raleway(
            fontWeight: FontWeight.bold,
            color: CustomColors.mainBlue,
            fontSize: 20,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        backgroundColor: CustomColors.mainBlue,
                        radius: 60,
                        child: Icon(
                          Icons.person_outline,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                    Container(height: 20),
                    Center(
                      child: Text(
                        name,
                        style: GoogleFonts.raleway(
                          color: CustomColors.mainBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(height: 100),
                    ProfileOptionTile(
                      onTap: () {
                        Authentication.logout();
                        Modular.to.pushReplacementNamed("/home");
                      },
                      text: "Sair",
                      icon: Icon(
                        Icons.door_back_door_outlined,
                        color: CustomColors.mainBlue,
                      ),
                    ),
                    Container(height: 50),
                  ],
                ),
              ),
            ),
          ],
        ),
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
