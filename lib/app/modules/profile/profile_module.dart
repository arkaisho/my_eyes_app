import 'package:my_eyes/app/modules/profile/datasources/profile_api.dart';
import 'package:my_eyes/app/modules/profile/pages/profile_page.dart';
import 'package:my_eyes/app/modules/profile/profile_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_eyes/app/utils/dio_config.dart';

class ProfileModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ProfileStore(i())),
    Bind.lazySingleton((i) => ProfileApi(DioConfig().dio)),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => ProfilePage(),
      transition: TransitionType.fadeIn,
    ),
  ];
}
