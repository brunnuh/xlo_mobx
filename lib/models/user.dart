import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';

enum UserType {PARTICULAR, PROFESSIONAL }


class User{
  String name;
  String email;
  String id;
  String phone;
  String password;
  UserType type;
  DateTime createdAt;

  User({this.id, this.name, this.email, this.createdAt, this.phone, this.password, this.type = UserType.PARTICULAR});

  @override
  String toString() {
    return 'User{name: $name, email: $email, id: $id, phone: $phone, password: $password, type: $type, createdAt: $createdAt}';
  }
}