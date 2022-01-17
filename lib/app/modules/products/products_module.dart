import 'package:my_eyes/app/modules/products/datasources/products_api.dart';
import 'package:my_eyes/app/modules/products/products_page.dart';
import 'package:my_eyes/app/modules/products/products_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_eyes/app/utils/dio_config.dart';

class ProductsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ProductsStore(i())),
    Bind.lazySingleton((i) => ProductsApi(DioConfig().dio)),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => ProductsPage()),
  ];
}
