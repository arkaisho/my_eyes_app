import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:my_eyes/app/modules/authentication/authentication_store.dart';
import 'package:my_eyes/app/shareds/circular_button.dart';
import 'package:my_eyes/app/shareds/custom_colors.dart';
import 'package:my_eyes/app/shareds/custom_text_form_field.dart';

class LoginPage extends StatefulWidget {
  final String title;

  const LoginPage({Key? key, this.title = 'LoginPage'}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final AuthenticationStore store = Modular.get();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          Modular.to.pushReplacementNamed("/home");
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: CustomColors.mainBlack,
              onPressed: () {
                Modular.to.pushReplacementNamed("/home");
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Stack(children: <Widget>[
              Column(children: [
                Padding(
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
                              child: Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    CustomTextFormField(
                                      controller: usernameController,
                                      hintText: "Nome de usuario",
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: CustomColors.mainBlue,
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty)
                                          return 'Informe um nome de usuário!';
                                        return null;
                                      },
                                    ),
                                    CustomTextFormField(
                                      controller: passwordController,
                                      hintText: "Senha",
                                      isPassword: true,
                                      validator: (value) {
                                        if (value!.isEmpty)
                                          return 'Informe uma senha!';
                                        return null;
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 30, top: 30),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              store.loading
                                                  ? Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    )
                                                  : Expanded(
                                                      child: CircularButton(
                                                        text: "Entrar",
                                                        onTap: () async {
                                                          if (formKey
                                                              .currentState!
                                                              .validate()) {
                                                            await store.login(
                                                              context,
                                                              username:
                                                                  usernameController
                                                                      .text,
                                                              password:
                                                                  passwordController
                                                                      .text,
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
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
                                    Modular.to.pushNamed("recover_password");
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Novo por aqui?",
                                      style: GoogleFonts.raleway(
                                        decoration: TextDecoration.underline,
                                        color: CustomColors.mainBlack
                                            .withOpacity(.5),
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
                                        Modular.to.pushNamed("sign_up");
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            ]),
          ),
        ),
      );
    });
  }
}
