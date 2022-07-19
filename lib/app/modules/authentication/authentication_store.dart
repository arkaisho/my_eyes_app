import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:my_eyes/app/modules/authentication/datasources/authentication_api.dart';
import 'package:my_eyes/app/utils/authentication.dart';
import 'package:my_eyes/app/utils/error_messager.dart';

part 'authentication_store.g.dart';

class AuthenticationStore = _AuthenticationStoreBase with _$AuthenticationStore;

abstract class _AuthenticationStoreBase with Store {
  final AuthenticationApi api;

  _AuthenticationStoreBase(this.api);

  @observable
  bool loading = false;

  @action
  Future login(
    BuildContext context, {
    required String username,
    required String password,
  }) async {
    loading = true;
    try {
      var response = await api.login({
        "username": username,
        "password": password,
      });
      await Authentication.saveToken(response.data['access'].toString());
      if (await Authentication.authenticated())
        Modular.to.pushReplacementNamed("/products");
    } catch (e) {
      showMessageError(
        context: context,
        error: e,
        defaultActionText: "Error ao realizar login",
        onlyDefault: true,
      );
    }
    loading = false;
  }

  @action
  Future register(
    BuildContext context, {
    required String email,
    required String name,
    required String username,
    required String password,
    required String confirmPassword,
  }) async {
    loading = true;
    try {
      await api.register({
        "user": {
          "name": name,
          "username": username,
          "email": email,
          "password": password,
          "re_password": confirmPassword,
        }
      });
      Modular.to.pop();
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Conta criada com sucesso."),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      showMessageError(
        context: context,
        error: e,
        defaultActionText: "Error ao realizar cadastro",
      );
    }
    loading = false;
  }

  @action
  Future recoverPassword(
    BuildContext context, {
    required String email,
  }) async {
    try {
      await api.recoverPassword({
        "email": email,
      });
      Modular.to.pop();
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email de mudança de senha enviado."),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      showMessageError(
        context: context,
        error: e,
        defaultActionText: "Error ao recuperar senha",
      );
    }
  }

  @action
  Future me() async {
    try {
      final token = await Authentication.getToken();
      var response = await api.me({'AUTHOZIRATION': 'JWT ' + token!});
      return response.data;
    } catch (e) {
      return null;
    }
  }
}
