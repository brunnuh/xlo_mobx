import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  final dynamic image;
  final VoidCallback onDelete;

  ImageDialog({@required this.image, @required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.file(image),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              onDelete();
            },
            child: Text('Excluir'),
          )
        ],
      ),
    );
  }
}
