import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_eyes/app/modules/authentication/authentication_store.dart';
import 'package:my_eyes/app/shareds/circular_button.dart';
import 'package:my_eyes/app/shareds/custom_colors.dart';

class RecoverPasswordPage extends StatefulWidget {
  const RecoverPasswordPage({Key? key}) : super(key: key);

  @override
  _RecoverPasswordPageState createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  final AuthenticationStore store = Modular.get();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: CustomColors.mainBlack,
          onPressed: () {
            Modular.to.pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Insira seu e-mail",
              style: GoogleFonts.raleway(
                fontWeight: FontWeight.bold,
                color: CustomColors.mainBlack.withOpacity(.5),
                fontSize: 16,
              ),
            ),
            TextFormField(
              controller: emailController,
              onEditingComplete: () {
                FocusScope.of(context).nextFocus();
              },
              decoration: InputDecoration(
                hintText: "E-mail",
                hintStyle: GoogleFonts.raleway(
                  color: CustomColors.mainBlack.withOpacity(.5),
                  fontSize: 14,
                ),
                focusColor: CustomColors.mainBlue,
                hoverColor: CustomColors.mainBlue,
                fillColor: CustomColors.mainBlue,
              ),
              cursorColor: CustomColors.mainBlue,
            ),
            Container(height: 20),
            Row(
              children: [
                Expanded(
                  child: CircularButton(
                    text: "Entrar",
                    onTap: () async {
                      await store.recoverPassword(
                        context,
                        email: emailController.text,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
