import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/screens/myads/my_ads_screen.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

class AccountScreen extends StatelessWidget {
  UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha conta'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          margin: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 140,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            userManagerStore.user.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Colors.purple,
                            ),
                          ),
                          Text(
                            userManagerStore.user.email,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.purple),
                        ),
                        child: Text('EDITAR'),
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Meus anúncios',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.purple,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => MyAdsScreen()),
                  );
                },
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
              ListTile(
                title: Text(
                  'Favoritos',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.purple,
                  ),
                ),
                onTap: () {},
                trailing: Icon(Icons.keyboard_arrow_right),
              )
            ],
          ),
        ),
      ),
    );
  }
}
