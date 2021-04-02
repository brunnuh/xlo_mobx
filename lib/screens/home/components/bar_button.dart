import 'package:flutter/material.dart';

class BarButton extends StatelessWidget {
  final String title;
  final BoxDecoration boxDecoration;
  final VoidCallback onTap;
  BarButton({this.title, this.boxDecoration, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: boxDecoration,
          height: 40,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
