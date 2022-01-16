import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_eyes/app/modules/home/datasource/home_api.dart';
import 'package:my_eyes/app/modules/login/login_module.dart';
import 'package:my_eyes/app/modules/signup/signup_module.dart';
import '../home/home_store.dart';

import 'pages/home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore(i())),
    Bind.lazySingleton((i) => HomeApi(Dio())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => HomePage()),
    ModuleRoute("\login", module:LoginModule()),
    ModuleRoute("\signup", module:SignupModule())
  ];
}
