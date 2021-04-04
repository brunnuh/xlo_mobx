import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/repositories/ad_repository.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

part 'myads_store.g.dart';

class MyadsStore = _MyadsStore with _$MyadsStore;

abstract class _MyadsStore with Store {
  _MyadsStore() {
    _getMyAds();
  }

  @observable
  List<Ad> allAds = [];

  @action
  Future<void> _getMyAds() async {
    final user = GetIt.I<UserManagerStore>().user;

    try {
      allAds = await AdRepository().getMyAds(user);
    } catch (e) {}
  }

  @computed
  List<Ad> get activeAds =>
      allAds.where((element) => element.status == AdStatus.ACTIVE).toList();
  List<Ad> get pendingAds =>
      allAds.where((element) => element.status == AdStatus.PENDING).toList();
  List<Ad> get soldAds =>
      allAds.where((element) => element.status == AdStatus.SOLD).toList();
}
