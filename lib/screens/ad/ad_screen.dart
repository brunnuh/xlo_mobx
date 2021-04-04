import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/screens/ad/components/bottom_bar.dart';

import 'components/description_panel.dart';
import 'components/location_panel.dart';
import 'components/main_panel.dart';
import 'components/user_panel.dart';

class AdScreen extends StatelessWidget {
  final Ad ad;

  AdScreen(this.ad);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anúncio'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                height: 280,
                child: Carousel(
                  images: ad.images
                      .map((url) => CachedNetworkImage(imageUrl: url))
                      .toList(),
                  dotSize: 4,
                  dotBgColor: Colors.transparent,
                  dotColor: Colors.orange,
                  autoplay: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MainPanel(ad),
                    Divider(
                      color: Colors.grey[500],
                    ),
                    DescriptionPanel(ad),
                    LocationPanel(ad),
                    Divider(
                      color: Colors.grey[500],
                    ),
                    UserPanel(ad),
                    SizedBox(
                      height: (ad.status == AdStatus.ACTIVE ? 120 : 40),
                    ),
                  ],
                ),
              )
            ],
          ),
          ad.status == AdStatus.PENDING ? Container() : BottomBar(ad),
        ],
      ),
    );
  }
}
