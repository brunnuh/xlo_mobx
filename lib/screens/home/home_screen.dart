import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/stores/home_store.dart';

import 'components/ad_tile.dart';
import 'components/create_ad_button.dart';
import 'components/search_dialog.dart';
import 'components/top_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  final ScrollController scrollController = ScrollController();

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
        body: Stack(
          children: [
            Column(
              children: [
                TopBar(),
                Expanded(
                  child: Observer(
                    builder: (_) {
                      if (homeStore.error != null) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error,
                                color: Colors.white,
                                size: 100,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                homeStore.error,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        );
                      }
                      if (homeStore.loading) {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                              Colors.white,
                            ),
                          ),
                        );
                      }
                      if (homeStore.adList.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.border_clear,
                                color: Colors.white,
                                size: 100,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'hmm.. nenhum anuncio encontrado.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        );
                      }
                      return ListView.builder(
                        controller: scrollController,
                        itemCount: homeStore.itemCount,
                        itemBuilder: (_, index) {
                          if (homeStore.adList.length > index) {
                            return AdTile(homeStore.adList[index]);
                          }
                          if (!homeStore.lastPage) {
                            homeStore.loadNextPage();
                            return Container(
                              height: 10,
                              child: LinearProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.purple),
                              ),
                            );
                          }
                          return Container();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: -50,
              left: 0,
              right: 0,
              child: CreateAdButton(scrollController),
            )
          ],
        ),
      ),
    );
  }
}
