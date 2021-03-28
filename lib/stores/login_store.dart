import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';
part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store{
 // Observers
 @observable
 String email;

 @action
 void setEmail(String value) => email = value;


 @computed
 bool get emailValid => email != null && email.isEmailValid();
 String get emailError {
   if(email == null || emailValid){
     return null;
   }else if(email.isEmpty){
     return "Campo Obrigatorio";
   }else{
     return "E-mail invalido";
   }
 }
 
 @observable
 String password;

 @action
 void setPassword(String value) => password = value;

 @computed
  bool get passwordValid => password != null && password.length >= 4;
  String get passwordError => password == null || passwordValid ? null : 'Senha invalida';

  @computed
  Function get loginPressed => emailValid && passwordValid && !loading ? _login : null;


  @observable
  bool loading = false;

  @observable
  String error;

  @action
  Future<void> _login() async {
   try{
     loading = true;

     final user = await UserRepository().loginWithEmail(email, password);
     GetIt.I<UserManagerStore>().setUser(user);
     loading = false;
   }catch(e){
     error = e;
   }

  }
}