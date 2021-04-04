import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/models/city.dart';
import 'package:xlo_mobx/models/uf.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';

enum AdStatus { PENDING, ACTIVE, SOLD, DELETED }

class Ad {
  String id;
  List images = [];
  String title;
  String description;

  Category category;
  Address address;
  num price;
  bool hidePhone = false;

  AdStatus status;
  DateTime created;

  User user;

  int views;

  Ad({
    this.id,
    this.images,
    this.title,
    this.description,
    this.category,
    this.address,
    this.price,
    this.hidePhone,
    this.status = AdStatus.PENDING,
    this.created,
    this.user,
    this.views,
  });

  factory Ad.fromParse(ParseObject parse) {
    return Ad(
      id: parse.objectId,
      title: parse.get<String>(keyAdTitle),
      description: parse.get<String>(keyAdDescription),
      images: parse.get<List>(keyAdImages).map((e) => e.url).toList(),
      price: parse.get<num>(keyAdPrice),
      hidePhone: parse.get<bool>(keyAdHidePhone),
      created: parse.createdAt,
      address: Address(
        district: parse.get<String>(keyAdDistrict),
        cep: parse.get<String>(keyAdPostalCode),
        uf: UF(
          initials: parse.get<String>(
            keyAdFederativeUnit,
          ),
        ),
        city: City(
          name: parse.get<String>(keyAdCity),
        ),
      ),
      views: parse.get<int>(keyAdViews, defaultValue: 0),
      user: UserRepository().toMap(parse.get<ParseUser>(keyAdOwner)),
      category: Category.fromParse(parse.get<ParseObject>(keyAdCategory)),
      status: AdStatus.values[parse.get<int>(keyAdStatus)],
    );
  }

  @override
  String toString() {
    return 'Ad{id: $id, images: $images, title: $title, description: $description, category: $category, address: $address, price: $price, hidePhone: $hidePhone, status: $status, created: $created, user: $user, views: $views}';
  }
}
