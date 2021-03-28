import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/screens/login/login_screen.dart';
import 'package:xlo_mobx/stores/page_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';


class CustomDrawerHeader extends StatelessWidget {

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Colors.purple,
        height: MediaQuery.of(context).size.height * 0.15,
        child: Center(
          child: ListTile(
            leading: Container(
              margin: EdgeInsets.only(top: 10),
              child: Icon(Icons.person, color: Colors.white,),
            ),
            title: Text(
                      userManagerStore.isLoggedIn
                      ? userManagerStore.user.name
                      : "Acesse sua Conta Agora!",
              style: TextStyle(color: Colors.white),),
            subtitle: Text(
                        userManagerStore.isLoggedIn
                        ? userManagerStore.user.email
                        : "Clique Aqui",
                style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      onTap: (){
        Navigator.of(context).pop();
        if(userManagerStore.isLoggedIn){
          GetIt.I<PageStore>().setPage(4);
        }else{
          Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => LoginScreen())
          );
        }

      },
    );
  }
}
