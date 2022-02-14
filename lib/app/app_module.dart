import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_eyes/app/modules/authentication/authentication_store.dart';
import 'package:my_eyes/app/modules/authentication/datasources/authentication_api.dart';
import 'package:my_eyes/app/modules/products/pages/qr_code_page.dart';
import 'package:my_eyes/app/modules/products/products_module.dart';
import 'package:my_eyes/app/modules/profile/profile_module.dart';
import 'package:my_eyes/app/modules/splash/splash_module.dart';
import 'package:my_eyes/app/utils/dio_config.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AuthenticationStore(i())),
    Bind.lazySingleton((i) => AuthenticationApi(DioConfig().dio)),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: SplashModule()),
    ModuleRoute("/home", module: HomeModule()),
    ModuleRoute("/products", module: ProductsModule()),
    ModuleRoute("/profile", module: ProfileModule()),
    ChildRoute(
      '/qr_code',
      child: (_, args) => QrCodePage(),
      transition: TransitionType.fadeIn,
    ),
  ];
}
