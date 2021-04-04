import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/repositories/ad_repository.dart';
import 'package:xlo_mobx/stores/cep_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

part 'create_store.g.dart';

class CreateStore = _CreateStore with _$CreateStore;

abstract class _CreateStore with Store {
  _CreateStore(this.ad) {
    title = ad.title ?? '';
    description = ad.description ?? '';
    images = ad.images != null ? ad.images.asObservable() : ObservableList();
    category = ad.category;
    priceText = ad.price?.formattedMoney(siflao: false) ?? '';
    hidePhone = ad.hidePhone;

    if (ad.address != null) {
      cepStore = CepStore(ad.address.cep);
    } else {
      cepStore = CepStore(null);
    }
  }

  final Ad ad;

  ObservableList images = ObservableList();

  @observable
  Category category;

  @action
  void setCategory(Category value) => category = value;

  @computed
  bool get categoryValid => category != null;
  String get categoryError {
    if (!showErrors || categoryValid)
      return null;
    else
      return 'Campo obrigatorio';
  }

  @observable
  bool hidePhone = false;

  @action
  void setPhone(bool value) => hidePhone = value;

  @computed
  bool get imagesValid => images.isNotEmpty;
  String get imagesError {
    if (!showErrors || imagesValid)
      return null;
    else
      return 'Insira Imagens';
  }

  @observable
  String title = '';

  @action
  void setTitle(String value) => title = value;

  @computed
  bool get titleValid => title.length >= 6;
  String get titleError {
    if (!showErrors ||
        titleValid) // se estiver mostrando os erros ou o titulo for menor que 6
      return null;
    else if (title.isEmpty)
      return 'Campo Obrigatorio';
    else
      return 'Titulo muito curto';
  }

  @observable
  String description = '';

  @action
  void setDecription(String value) => description = value;

  @computed
  bool get descriptionValid => description.length >= 5;
  String get descriptionError {
    if (!showErrors || descriptionValid) {
      return null;
    } else if (description.isEmpty) {
      return 'Campo Obrigatorio';
    } else {
      return 'Campo muito curto';
    }
  }

  CepStore cepStore;

  @computed
  Address get address => cepStore.address;
  bool get addressValid => address != null;
  String get addressError {
    if (!showErrors || addressValid)
      return null;
    else
      return 'Campo obrigatorio';
  }

  @observable
  String priceText = '';

  @action
  void setPrice(String value) => priceText = value;

  @computed
  num get price {
    if (priceText.contains(',')) {
      return num.tryParse(priceText.replaceAll(RegExp('[^0-9]'), '')) / 100;
    } else {
      return num.tryParse(priceText);
    }
  }

  bool get priceValid => price != null && price <= 999999;
  String get priceError {
    if (!showErrors || priceValid)
      return null;
    else if (priceText.isEmpty)
      return 'Campo obrigatorio';
    else
      return 'Preço invalido';
  }

  @computed
  bool get formValid =>
      imagesValid &&
      titleValid &&
      descriptionValid &&
      categoryValid &&
      addressValid &&
      priceValid;

  @computed
  Function get sendPressed => formValid ? _send : null;

  @observable
  bool showErrors = false;

  @action
  void invalidSendPressed() => showErrors = true;

  @observable
  bool loading = false;

  @observable
  String error;

  @observable
  bool savedAd;

  @action
  Future<void> _send() async {
    ad.title = title;
    ad.description = description;
    images = images;
    ad.address = address;
    ad.category = category;
    ad.price = price;
    ad.hidePhone = hidePhone;
    ad.user = GetIt.I<UserManagerStore>().user;

    loading = true;
    try {
      await AdRepository().save(ad);
      savedAd = true;
    } catch (e) {
      error = e;
    }
    loading = false;
  }
}
