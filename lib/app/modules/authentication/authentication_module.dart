import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_eyes/app/modules/authentication/authentication_store.dart';
import 'package:my_eyes/app/modules/authentication/datasources/authentication_api.dart';
import 'package:my_eyes/app/modules/authentication/pages/login_page.dart';
import 'package:my_eyes/app/modules/authentication/pages/recover_password_page.dart';
import 'package:my_eyes/app/modules/authentication/pages/signup_page.dart';
import 'package:my_eyes/app/utils/dio_config.dart';

class AuthenticationModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AuthenticationStore(i())),
    Bind.lazySingleton((i) => AuthenticationApi(DioConfig().dio)),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => LoginPage()),
    ChildRoute('/recover_password', child: (_, args) => RecoverPasswordPage()),
    ChildRoute('/sign_up', child: (_, args) => SignupPage()),
  ];
}
