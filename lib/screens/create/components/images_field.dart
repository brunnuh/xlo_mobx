import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/create/components/image_source_modal.dart';
import 'package:xlo_mobx/stores/create_store.dart';

import 'image_dialog.dart';

class ImagesField extends StatelessWidget {
  final CreateStore createStore;

  const ImagesField(this.createStore);

  @override
  Widget build(BuildContext context) {
    void onImageSelected(File image) {
      //envia callback como parametro, retorna com a imagem, e fecha o dialogo
      createStore.images.add(image);
      Navigator.of(context).pop();
    }

    return Column(
      children: [
        Container(
          color: Colors.grey[200],
          height: 120,
          child: Observer(
            builder: (_) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: createStore.images.length < 5
                    ? createStore.images.length + 1
                    : createStore.images.length,
                itemBuilder: (_, index) {
                  if (index == createStore.images.length) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(
                        8,
                        8,
                        index == 4 ? 8 : 0,
                        8,
                      ),
                      child: GestureDetector(
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey[300],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                size: 50,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          if (Platform.isAndroid) {
                            showModalBottomSheet(
                              context: context,
                              builder: (_) => ImageSourceModal(onImageSelected),
                            );
                          } else {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (_) => ImageSourceModal(onImageSelected),
                            );
                          }
                        },
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                      child: GestureDetector(
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: createStore.images[index] is File
                              ? FileImage(createStore.images[index])
                              : NetworkImage(createStore.images[index]),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => ImageDialog(
                              image: createStore.images[index],
                              onDelete: () {
                                createStore.images.removeAt(index);
                              },
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              );
            },
          ),
        ),
        Observer(
          builder: (_) => createStore.imagesError != null
              ? Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(16, 8, 0, 8),
                  decoration: BoxDecoration(
                      border: Border(
                    top: BorderSide(
                      color: Colors.red,
                    ),
                  )),
                  child: Text(
                    createStore.imagesError,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                )
              : Container(),
        )
      ],
    );
  }
}
