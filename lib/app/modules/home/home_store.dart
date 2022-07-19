import 'package:flutter_tts/flutter_tts.dart';
import 'package:mobx/mobx.dart';
import 'package:my_eyes/app/modules/home/datasource/home_api.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final HomeApi api;
  FlutterTts flutterTts = FlutterTts();

  @observable
  String lastReadCode = "";

  @observable
  DateTime lastReadedTime = DateTime.now();

  @computed
  Duration get timeSinceLastRead => DateTime.now().difference(lastReadedTime);

  @computed
  bool get canReadAgain =>
      timeSinceLastRead.compareTo(Duration(seconds: 2)) > 0;

  HomeStoreBase(this.api) {
    flutterTts.awaitSpeakCompletion(true);
    flutterTts.setLanguage("pt-BR");
  }

  Future speak(String text) async {
    await flutterTts.stop();
    await flutterTts.speak(text);
    lastReadCode = "";
  }
}
