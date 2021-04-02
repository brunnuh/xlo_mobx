import 'package:flutter/material.dart';

import 'bar_button.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BarButton(
          title: 'Categorias',
          boxDecoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[400],
              ),
              right: BorderSide(
                color: Colors.grey[400],
              ),
            ),
          ),
          onTap: () {},
        ),
        BarButton(
          title: 'Filtros',
          boxDecoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[400],
              ),
            ),
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
