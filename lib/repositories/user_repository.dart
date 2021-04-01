import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/parse_errors.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';

class UserRepository {
  Future<User> signUp(User user) async {
    final parseUser = ParseUser(user.email, user.password, user.email);

    parseUser.set<String>(keyUserName, user.name);
    parseUser.set<String>(keyUserPhone, user.phone);
    parseUser.set(keyUserType, user.type.index);

    final response = await parseUser.signUp();

    if (response.success) {
      return toMap(response.result);
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<User> loginWithEmail(String email, String password) async {
    final parseUser = ParseUser(email, password, email);

    final response = await parseUser.login();
    if (response.success) {
      return toMap(response.result);
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  User toMap(ParseUser parseUser) {
    return User(
        id: parseUser.objectId,
        name: parseUser.get(keyUserName),
        email: parseUser.get(keyUserEmail),
        phone: parseUser.get(keyUserPhone),
        type: UserType.values[parseUser.get(
          keyUserType,
        )],
        createdAt: parseUser.get(KeyUserCreatedAt));
  }

  Future<User> currentUser() async {
    final ParseUser parseUser =
        await ParseUser.currentUser(); // verifica se esta logado
    if (parseUser != null) {
      final response = await ParseUser.getCurrentUserFromServer(
          parseUser.sessionToken); // pega os dados
      if (response.success) {
        // se nao estiver expirado
        return toMap(response.result);
      } else {
        // desloga
        await parseUser.logout();
      }
    }
    return null;
  }
}
