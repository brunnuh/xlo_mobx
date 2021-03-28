import 'package:flutter/material.dart';


class PageTile extends StatelessWidget {
  final String label;
  final IconData iconData;
  final bool highlighted;
  final VoidCallback onTap;

  const PageTile({Key key, this.label, this.iconData, this.highlighted, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          color: highlighted ? Colors.purple : Colors.black54,
          fontWeight: FontWeight.w700
        ),
      ),
      leading: Icon(
        iconData,
        color: highlighted ? Colors.purple : Colors.black54,
      ),
      onTap: onTap,

    );
  }
}
