// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on HomeStoreBase, Store {
  Computed<Duration>? _$timeSinceLastReadComputed;

  @override
  Duration get timeSinceLastRead => (_$timeSinceLastReadComputed ??=
          Computed<Duration>(() => super.timeSinceLastRead,
              name: 'HomeStoreBase.timeSinceLastRead'))
      .value;
  Computed<bool>? _$canReadAgainComputed;

  @override
  bool get canReadAgain =>
      (_$canReadAgainComputed ??= Computed<bool>(() => super.canReadAgain,
              name: 'HomeStoreBase.canReadAgain'))
          .value;

  final _$lastReadCodeAtom = Atom(name: 'HomeStoreBase.lastReadCode');

  @override
  String get lastReadCode {
    _$lastReadCodeAtom.reportRead();
    return super.lastReadCode;
  }

  @override
  set lastReadCode(String value) {
    _$lastReadCodeAtom.reportWrite(value, super.lastReadCode, () {
      super.lastReadCode = value;
    });
  }

  final _$lastReadedTimeAtom = Atom(name: 'HomeStoreBase.lastReadedTime');

  @override
  DateTime get lastReadedTime {
    _$lastReadedTimeAtom.reportRead();
    return super.lastReadedTime;
  }

  @override
  set lastReadedTime(DateTime value) {
    _$lastReadedTimeAtom.reportWrite(value, super.lastReadedTime, () {
      super.lastReadedTime = value;
    });
  }

  @override
  String toString() {
    return '''
lastReadCode: ${lastReadCode},
lastReadedTime: ${lastReadedTime},
timeSinceLastRead: ${timeSinceLastRead},
canReadAgain: ${canReadAgain}
    ''';
  }
}
