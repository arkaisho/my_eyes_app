import 'package:mobx/mobx.dart';
import 'package:my_eyes/app/modules/profile/datasources/profile_api.dart';
import 'package:my_eyes/app/utils/authentication.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStoreBase with _$ProfileStore;

abstract class _ProfileStoreBase with Store {
  final ProfileApi api;
  _ProfileStoreBase(this.api);

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
