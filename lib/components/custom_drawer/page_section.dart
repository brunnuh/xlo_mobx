import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/custom_drawer/page_tile.dart';
import 'package:xlo_mobx/stores/page_store.dart';

class PageSection extends StatelessWidget {
  final PageStore pageStore = GetIt.I<PageStore>(); //instancia de pagestore

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageTile(
          label: 'Anuncios',
          iconData: Icons.list,
          onTap: () {
            pageStore.setPage(0);
          },
          highlighted:  pageStore.page == 0,
        ),
        PageTile(
          label: 'Inserir Anuncio',
          iconData: Icons.edit,
          onTap: () {
            pageStore.setPage(1);
          },
          highlighted:  pageStore.page == 1,
        ),
        PageTile(
          label: 'Chat',
          iconData: Icons.chat,
          onTap: () {
            pageStore.setPage(2);
          },
          highlighted:  pageStore.page == 2,
        ),
        PageTile(
          label: 'Favoritos',
          iconData: Icons.favorite,
          onTap: () {
            pageStore.setPage(3);
          },
          highlighted:  pageStore.page == 3,
        ),
        PageTile(
          label: 'Minha Conta',
          iconData: Icons.person,
          onTap: () {
            pageStore.setPage(4);
          },
          highlighted: pageStore.page == 4,
        )
      ],
    );
  }
}
