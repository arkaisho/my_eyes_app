import 'package:mobx/mobx.dart';
import 'package:my_eyes/app/modules/home/datasource/home_api.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final HomeApi api;

  HomeStoreBase(this.api);

  @observable
  String result = "Click on the button to make a request";

  Future getTodos() async {
    result = (await api.getTodos()).toString();
  }
}
