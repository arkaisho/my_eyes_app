import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_eyes/app/modules/authentication/pages/login_page.dart';
import 'package:my_eyes/app/modules/authentication/pages/recover_password_page.dart';
import 'package:my_eyes/app/modules/authentication/pages/signup_page.dart';

class AuthenticationModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => LoginPage(),
      transition: TransitionType.fadeIn,
    ),
    ChildRoute(
      '/recover_password',
      child: (_, args) => RecoverPasswordPage(),
      transition: TransitionType.fadeIn,
    ),
    ChildRoute(
      '/sign_up',
      child: (_, args) => SignupPage(),
      transition: TransitionType.fadeIn,
    ),
  ];
}
