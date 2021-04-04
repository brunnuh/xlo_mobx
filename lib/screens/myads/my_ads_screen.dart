import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/myads/components/sold_tile.dart';
import 'package:xlo_mobx/stores/myads_store.dart';

import 'components/active_tile.dart';
import 'components/pending_tile.dart';

class MyAdsScreen extends StatefulWidget {
  final int initialPage;

  MyAdsScreen({this.initialPage = 0});

  @override
  _MyAdsScreenState createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  final MyadsStore myAdsStore = MyadsStore();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController =
        TabController(length: 3, vsync: this, initialIndex: widget.initialPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus anúncios'),
        centerTitle: true,
        bottom: TabBar(
          indicatorColor: Colors.orange,
          controller: tabController,
          tabs: [
            Tab(
              child: Text('ATIVOS'),
            ),
            Tab(
              child: Text('PENDENTES'),
            ),
            Tab(
              child: Text('VENDIDOS'),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          Observer(
            builder: (_) {
              return myAdsStore.activeAds.isEmpty
                  ? Container()
                  : ListView.builder(
                      itemCount: myAdsStore.activeAds.length,
                      itemBuilder: (_, index) {
                        return ActiveTile(myAdsStore.activeAds[index]);
                      },
                    );
            },
          ),
          Observer(
            builder: (_) {
              return myAdsStore.pendingAds.isEmpty
                  ? Container()
                  : ListView.builder(
                      itemCount: myAdsStore.pendingAds.length,
                      itemBuilder: (_, index) {
                        return PendingTile(myAdsStore.pendingAds[index]);
                      },
                    );
            },
          ),
          Observer(
            builder: (_) {
              return myAdsStore.soldAds.isEmpty
                  ? Container()
                  : ListView.builder(
                      itemCount: myAdsStore.soldAds.length,
                      itemBuilder: (_, index) {
                        return SoldTile(myAdsStore.soldAds[index]);
                      },
                    );
            },
          ),
        ],
      ),
    );
  }
}
