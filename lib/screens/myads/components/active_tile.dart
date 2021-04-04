import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/models/ad.dart';

class ActiveTile extends StatelessWidget {
  final Ad ad;

  ActiveTile(this.ad);

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
            )
          ],
        ),
      ),
    );
  }
}
