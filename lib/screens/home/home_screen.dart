import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/stores/home_store.dart';

import 'components/search_dialog.dart';
import 'components/top_bar.dart';

class HomeScreen extends StatelessWidget {
  openSearch(BuildContext context) async {
    final search = await showDialog(
      context: context,
      builder: (_) => SearchDialog(
        currentSearch: homeStore.search,
      ),
    );
    if (search != null) {
      homeStore.setSearch(search);
    }
  }

  final HomeStore homeStore = GetIt.I<HomeStore>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // tirando a barra do celular do drawer
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: Observer(
            builder: (_) => homeStore.search.isEmpty
                ? Container()
                : GestureDetector(
                    child: LayoutBuilder(
                      // cria um layout min e max para o widget
                      builder: (_, constraints) {
                        return Container(
                          width: constraints
                              .biggest.width, // maior largura possivel
                          child: Text(homeStore.search),
                        );
                      },
                    ),
                    onTap: () => openSearch(context),
                  ),
          ),
          actions: [
            Observer(builder: (_) {
              return IconButton(
                icon: homeStore.search.isEmpty
                    ? Icon(Icons.search)
                    : Icon(Icons.close),
                onPressed: () {
                  if (homeStore.search.isEmpty)
                    openSearch(context);
                  else
                    homeStore.setSearch('');
                },
              );
            })
          ],
        ),
        body: Column(
          children: [
            TopBar(),
          ],
        ),
      ),
    );
  }
}
