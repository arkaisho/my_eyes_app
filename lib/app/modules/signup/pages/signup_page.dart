import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_eyes/app/modules/signup/signup_store.dart';
import 'package:flutter/material.dart';
import 'package:my_eyes/app/shareds/circular_button.dart';
import 'package:my_eyes/app/shareds/custom_colors.dart';

class SignupPage extends StatefulWidget {
  final String title;

  const SignupPage({Key? key, this.title = 'Cadastro'}) : super(key: key);

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final SignupStore store = Modular.get();
  bool _hidePassword = true;
  bool _hidePasswordConfirmation = true;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  hintText: "Nome",
                                  hintStyle: GoogleFonts.raleway(
                                    color:
                                        CustomColors.mainBlack.withOpacity(.5),
                                    fontSize: 14,
                                  ),
                                  focusColor: CustomColors.mainBlue,
                                  hoverColor: CustomColors.mainBlue,
                                  fillColor: CustomColors.mainBlue,
                                  prefixIcon: Icon(
                                    Icons.person_add_disabled,
                                    color: CustomColors.mainBlue,
                                  ),
                                ),
                                cursorColor: CustomColors.mainBlue,
                                validator: (value) {
                                  if (value!.isEmpty)
                                    return 'Informe seu nome!';
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: "Endereço de e-mail",
                                  hintStyle: GoogleFonts.raleway(
                                    color:
                                        CustomColors.mainBlack.withOpacity(.5),
                                    fontSize: 14,
                                  ),
                                  focusColor: CustomColors.mainBlue,
                                  hoverColor: CustomColors.mainBlue,
                                  fillColor: CustomColors.mainBlue,
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: CustomColors.mainBlue,
                                  ),
                                ),
                                cursorColor: CustomColors.mainBlue,
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
                              child: TextFormField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  hintText: "Nome de usuário",
                                  hintStyle: GoogleFonts.raleway(
                                    color:
                                        CustomColors.mainBlack.withOpacity(.5),
                                    fontSize: 14,
                                  ),
                                  focusColor: CustomColors.mainBlue,
                                  hoverColor: CustomColors.mainBlue,
                                  fillColor: CustomColors.mainBlue,
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: CustomColors.mainBlue,
                                  ),
                                ),
                                cursorColor: CustomColors.mainBlue,
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
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: _hidePassword,
                                decoration: InputDecoration(
                                  hintText: 'Senha',
                                  hintStyle: GoogleFonts.raleway(
                                    color:
                                        CustomColors.mainBlack.withOpacity(.5),
                                    fontSize: 14,
                                  ),
                                  focusColor: CustomColors.mainBlue,
                                  hoverColor: CustomColors.mainBlue,
                                  fillColor: CustomColors.mainBlue,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _hidePassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _hidePassword = !_hidePassword;
                                      });
                                    },
                                  ),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: CustomColors.mainBlue,
                                  ),
                                ),
                                cursorColor: CustomColors.mainBlue,
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
                              child: TextFormField(
                                controller: _passwordConfirmationController,
                                obscureText: _hidePasswordConfirmation,
                                decoration: InputDecoration(
                                  hintText: "Confirmação da senha",
                                  hintStyle: GoogleFonts.raleway(
                                    color:
                                        CustomColors.mainBlack.withOpacity(.5),
                                    fontSize: 14,
                                  ),
                                  focusColor: CustomColors.mainBlue,
                                  hoverColor: CustomColors.mainBlue,
                                  fillColor: CustomColors.mainBlue,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _hidePasswordConfirmation
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _hidePasswordConfirmation =
                                            !_hidePasswordConfirmation;
                                      });
                                    },
                                  ),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: CustomColors.mainBlue,
                                  ),
                                ),
                                cursorColor: CustomColors.mainBlue,
                                validator: (value) {
                                  if (value!.isEmpty)
                                    return 'confirme sua senha!';
                                  if (value !=
                                      _passwordController.text)
                                    return 'As senhas não coincidem!';
                                },
                              ),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 30, top: 30),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CircularButton(
                                              text: "Cadastro",
                                              onTap: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      backgroundColor:
                                                          Colors.greenAccent,
                                                      content: Text(
                                                        'Tudo OK',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ])),
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
                                Modular.to.pushNamed("/login");
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
  }
}
