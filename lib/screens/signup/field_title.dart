import 'package:flutter/material.dart';

class FieldTitle extends StatelessWidget {

  final String title;
  final String subtitle;

  const FieldTitle({Key key, this.title, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, top: 4, right: 16),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(right: 56),
            child: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16
              ),
            ),
          ),
          Container(
            //padding: EdgeInsets.only(left: 16),
            child: Text(subtitle, style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.grey
            ),),
          )
        ],
      ),
    );
  }
}
