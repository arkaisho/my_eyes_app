import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_eyes/app/modules/login/login_store.dart';
import 'package:flutter/material.dart';
import 'package:my_eyes/app/shareds/circular_button.dart';
import 'package:my_eyes/app/shareds/custom_colors.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key? key, this.title = 'LoginPage'}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final LoginStore store = Modular.get();

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
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Text(
                          "Login",
                          style: GoogleFonts.raleway(
                            fontWeight: FontWeight.bold,
                            color: CustomColors.mainBlue,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Text(
                          "Bem vindo de volta!",
                          style: GoogleFonts.raleway(
                            fontWeight: FontWeight.bold,
                            color: CustomColors.mainBlack.withOpacity(.5),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Form(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Usuário ou email",
                                    hintStyle: GoogleFonts.raleway(
                                      color: CustomColors.mainBlack
                                          .withOpacity(.5),
                                      fontSize: 14,
                                    ),
                                    focusColor: CustomColors.mainBlue,
                                    hoverColor: CustomColors.mainBlue,
                                    fillColor: CustomColors.mainBlue,
                                  ),
                                  cursorColor: CustomColors.mainBlue,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: "Senha",
                                    hintStyle: GoogleFonts.raleway(
                                      color: CustomColors.mainBlack
                                          .withOpacity(.5),
                                      fontSize: 14,
                                    ),
                                    focusColor: CustomColors.mainBlue,
                                    hoverColor: CustomColors.mainBlue,
                                    fillColor: CustomColors.mainBlue,
                                  ),
                                  cursorColor: CustomColors.mainBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: InkWell(
                          child: Text(
                            "Esqueceu sua senha?",
                            style: GoogleFonts.raleway(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.mainBlue,
                              fontSize: 14,
                            ),
                          ),
                          onTap: () {
                            //TODO make route to recover password
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CircularButton(
                          text: "Entrar",
                          onTap: () {
                            //TODO make route to recover profile
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Novo por aqui?",
                        style: GoogleFonts.raleway(
                          decoration: TextDecoration.underline,
                          color: CustomColors.mainBlack.withOpacity(.5),
                          fontSize: 14,
                        ),
                      ),
                      InkWell(
                        child: Text(
                          " Cadastre-se",
                          style: GoogleFonts.raleway(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.mainBlue,
                            fontSize: 14,
                          ),
                        ),
                        onTap: () {
                          Modular.to.pushNamed("/signup");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
