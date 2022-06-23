import 'package:my_eyes/app/modules/products/datasources/products_api.dart';
import 'package:my_eyes/app/modules/products/pages/product_creation_page.dart';
import 'package:my_eyes/app/modules/products/pages/product_details_page.dart';
import 'package:my_eyes/app/modules/products/pages/product_edition_page.dart';
import 'package:my_eyes/app/modules/products/pages/products_page.dart';
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
    ChildRoute(
      '/',
      child: (_, args) => ProductsPage(),
      transition: TransitionType.fadeIn,
    ),
    ChildRoute(
      '/product_creation',
      child: (_, args) => ProductCreationPage(),
      transition: TransitionType.fadeIn,
    ),
    ChildRoute(
      '/product_edition',
      child: (_, args) => ProductEditionPage(),
      transition: TransitionType.fadeIn,
    ),
    ChildRoute(
      '/product_details',
      child: (_, args) => ProductDetailsPage(),
      transition: TransitionType.fadeIn,
    ),
  ];
}
