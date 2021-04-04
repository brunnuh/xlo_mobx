// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myads_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MyadsStore on _MyadsStore, Store {
  Computed<List<Ad>> _$activeAdsComputed;

  @override
  List<Ad> get activeAds =>
      (_$activeAdsComputed ??= Computed<List<Ad>>(() => super.activeAds,
              name: '_MyadsStore.activeAds'))
          .value;

  final _$allAdsAtom = Atom(name: '_MyadsStore.allAds');

  @override
  List<Ad> get allAds {
    _$allAdsAtom.reportRead();
    return super.allAds;
  }

  @override
  set allAds(List<Ad> value) {
    _$allAdsAtom.reportWrite(value, super.allAds, () {
      super.allAds = value;
    });
  }

  final _$_getMyAdsAsyncAction = AsyncAction('_MyadsStore._getMyAds');

  @override
  Future<void> _getMyAds() {
    return _$_getMyAdsAsyncAction.run(() => super._getMyAds());
  }

  @override
  String toString() {
    return '''
allAds: ${allAds},
activeAds: ${activeAds}
    ''';
  }
}
