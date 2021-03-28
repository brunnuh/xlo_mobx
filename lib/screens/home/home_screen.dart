import 'package:flutter/material.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea( // tirando a barra do celular do drawer
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(),
      ),
    );
  }
}
