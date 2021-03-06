import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/category/category_screen.dart';
import 'package:xlo_mobx/stores/create_store.dart';

class CategoryField extends StatelessWidget {
  final CreateStore createStore;

  CategoryField(this.createStore);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Column(
          children: [
            ListTile(
              title: Text(
                "Categoria *",
                style: TextStyle(
                  fontWeight: createStore.category == null
                      ? FontWeight.w800
                      : FontWeight.w700,
                  color: Colors.grey,
                  fontSize: createStore.category == null ? 18 : 14,
                ),
              ),
              subtitle: createStore.category == null
                  ? null
                  : Text(
                      '${createStore.category.description}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: () async {
                final category = await showDialog(
                  context: context,
                  builder: (_) => CategoryScreen(
                    showAll: false,
                    selected: createStore.category,
                  ),
                );
                if (category != null) {
                  createStore.setCategory(category);
                }
              },
            ),
            createStore.categoryError != null
                ? Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(16, 8, 0, 0),
                    decoration: BoxDecoration(
                        border: Border(
                      top: BorderSide(
                        color: Colors.red,
                      ),
                    )),
                    child: Text(
                      createStore.categoryError,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }
}
