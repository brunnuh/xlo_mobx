import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/screens/create/create_screen.dart';
import 'package:xlo_mobx/screens/home/home_screen.dart';
import 'package:xlo_mobx/stores/page_store.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController _pageController = PageController();

  final PageStore pageStore = GetIt.I<PageStore>(); //instancia de pagestore

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    reaction(
        // toda vez que houver uma mudanca no observable, aciona acao
        (_) => pageStore.page, // observable
        (page) => _pageController.jumpToPage(page) // acao
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics:
            NeverScrollableScrollPhysics(), // bloqueia a fisica de arrastar para os lados
        children: [
          HomeScreen(),
          CreateScreen(),
          Scaffold(
            drawer: CustomDrawer(),
          ),
          Container(color: Colors.purple),
          Container(color: Colors.brown),
        ],
      ),
    );
  }
}
