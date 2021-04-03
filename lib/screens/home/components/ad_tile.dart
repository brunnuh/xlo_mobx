import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/models/ad.dart';

class AdTile extends StatelessWidget {
  final Ad ad;

  AdTile(this.ad);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
        child: Row(
          children: [
            SizedBox(
              height: 135,
              width: 127,
              child: CachedNetworkImage(
                imageUrl: ad.images.isEmpty
                    ? 'https://levecrock.com.br/wp-content/uploads/2020/05/Produto-sem-Imagem-por-Enquanto.jpg'
                    : ad.images.first,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ad.title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${ad.price.formattedMoney()}',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${ad.created.formattedDate()} - ${ad.address.city.name} - ${ad.address.uf.initials}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}