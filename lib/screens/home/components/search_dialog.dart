import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {
  final String currentSearch;
  SearchDialog({this.currentSearch})
      : controller = TextEditingController(text: currentSearch);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 2,
          left: 2,
          right: 2,
          child: Card(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                prefixIcon: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.grey[700],
                  onPressed: Navigator.of(context).pop,
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.close),
                  color: Colors.grey[700],
                  onPressed: controller.clear,
                ),
              ),
              textInputAction: TextInputAction.search,
              autofocus: true,
              onSubmitted: (text) {
                Navigator.of(context).pop(text);
              },
            ),
          ),
        )
      ],
    );
  }
}
