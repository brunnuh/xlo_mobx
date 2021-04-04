import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/models/ad.dart';

class ActiveTile extends StatelessWidget {
  final Ad ad;

  ActiveTile(this.ad);

  final List<MenuChoice> choices = [
    MenuChoice(index: 0, title: 'Editar', iconData: Icons.edit),
    MenuChoice(index: 1, title: 'Já vendi', iconData: Icons.thumb_up),
    MenuChoice(index: 2, title: 'Excluir', iconData: Icons.delete),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      child: Container(
        height: 80,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1.5,
              child: CachedNetworkImage(
                imageUrl: ad.images.first,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    ad.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    ad.price.formattedMoney(),
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    '${ad.views} visita(s)',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[800],
                    ),
                  )
                ],
              ),
            ),
            PopupMenuButton<MenuChoice>(
              onSelected: (choice) {
                switch (choice.index) {
                  case 0:
                    break;
                  case 1:
                    break;
                  case 2:
                    break;
                }
              },
              itemBuilder: (_) {
                return choices
                    .map(
                      (choice) => PopupMenuItem<MenuChoice>(
                        value: choice,
                        child: Row(
                          children: [
                            Icon(
                              choice.iconData,
                              size: 20,
                              color: Colors.purple,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              choice.title,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.purple,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                    .toList();
              },
            )
          ],
        ),
      ),
    );
  }
}

class MenuChoice {
  final int index;
  final String title;
  final IconData iconData;

  MenuChoice({this.index, this.title, this.iconData});
}
