import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_eyes/app/modules/authentication/authentication_store.dart';
import 'package:flutter/material.dart';
import 'package:my_eyes/app/shareds/circular_button.dart';
import 'package:my_eyes/app/shareds/custom_colors.dart';
import 'package:my_eyes/app/shareds/custom_text_form_field.dart';

class SignupPage extends StatefulWidget {
  final String title;

  const SignupPage({Key? key, this.title = 'Cadastro'}) : super(key: key);

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final AuthenticationStore store = Modular.get();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
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
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30, left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Text(
                          "Cadastro",
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
                          "Informações da loja!",
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
                          key: formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: CustomTextFormField(
                                  controller: nameController,
                                  hintText: "Nome",
                                  prefixIcon: Icon(
                                    Icons.person_outline,
                                    color: CustomColors.mainBlue,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty)
                                      return 'Informe seu nome!';
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: CustomTextFormField(
                                  controller: emailController,
                                  hintText: "Endereço de e-mail",
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    color: CustomColors.mainBlue,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty)
                                      return 'Informe um email!';
                                    else if (!RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value))
                                      return 'Informe um email válido!';
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: CustomTextFormField(
                                  controller: usernameController,
                                  hintText: "Nome de usuário",
                                  prefixIcon: Icon(
                                    Icons.text_fields_outlined,
                                    color: CustomColors.mainBlue,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty)
                                      return 'Informe o nome de usuário!';
                                    else if (value.length < 6)
                                      return 'Informe um nome de usuário com no mínimo 4 caracteres!';
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: CustomTextFormField(
                                  controller: passwordController,
                                  hintText: 'Senha',
                                  isPassword: true,
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: CustomColors.mainBlue,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty)
                                      return 'informe sua senha!';
                                    else if (value.length < 6)
                                      return 'informe uma senha com no mínimo 6 caracteres!';
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: CustomTextFormField(
                                  controller: passwordConfirmationController,
                                  hintText: "Confirmação da senha",
                                  isPassword: true,
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: CustomColors.mainBlue,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty)
                                      return 'confirme sua senha!';
                                    if (value != passwordController.text)
                                      return 'As senhas não coincidem!';
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 30, top: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        store.loading
                                            ? CircularProgressIndicator()
                                            : Expanded(
                                                child: CircularButton(
                                                  text: "Cadastro",
                                                  onTap: () async {
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      await store.register(
                                                        context,
                                                        name:
                                                            nameController.text,
                                                        email: emailController
                                                            .text,
                                                        username:
                                                            usernameController
                                                                .text,
                                                        password:
                                                            passwordController
                                                                .text,
                                                        confirmPassword:
                                                            passwordConfirmationController
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
                    ],
                  ),
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(bottom: 30, left: 30, right: 30),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Já possui uma conta?",
                                style: GoogleFonts.raleway(
                                  decoration: TextDecoration.underline,
                                  color: CustomColors.mainBlack.withOpacity(.5),
                                  fontSize: 14,
                                ),
                              ),
                              InkWell(
                                child: Text(
                                  " Faça login",
                                  style: GoogleFonts.raleway(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.mainBlue,
                                    fontSize: 14,
                                  ),
                                ),
                                onTap: () {
                                  Modular.to.pop();
                                },
                              ),
                            ],
                          ),
                        ])),
              ]),
            ],
          ),
        ),
      );
    });
  }
}
