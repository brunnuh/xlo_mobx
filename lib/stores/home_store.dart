import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/repositories/ad_repository.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  _HomeStore() {
    autorun((_) async {
      try {
        if (page == 0) {
          setLoading(true);
        }

        final newAds = await AdRepository().getHomeAdList(
          // quando houver qlqr mudanca em algum dos observables abaixo, chama o getHomeList
          filter: filter,
          search: search,
          category: category,
          page: page,
        );
        addNewsAds(newAds);
        setLoading(false);
        setError(null);
      } catch (e) {
        setError(e);
      }
    });
  }

  ObservableList<Ad> adList = ObservableList<Ad>();

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @observable
  String error;

  @action
  void setError(String value) => error = value;

  @observable
  String search = '';

  @action
  void setSearch(String value) {
    search = value;
    resetPage();
  }

  @observable
  Category category;

  @action
  void setCategory(Category value) {
    category = value;
    resetPage();
  }

  @observable
  FilterStore filter = FilterStore();

  FilterStore get cloneFilter => filter.clone();

  @action
  void setFilter(FilterStore value) {
    filter = value;
    resetPage();
  }

  @observable
  int page = 0;

  @action
  void loadNextPage() => page++;

  @computed
  int get itemCount => lastPage ? adList.length : adList.length + 1;

  @observable
  bool lastPage = false;

  @action
  void addNewsAds(List<Ad> newAds) {
    if (newAds.length < 10) {
      lastPage = true;
    }
    adList.addAll(newAds);
  }

  void resetPage() {
    page = 0;
    adList.clear();
    lastPage = false;
  }
}
