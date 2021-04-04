import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/stores/create_store.dart';

class HidePhoneField extends StatelessWidget {
  final CreateStore createStore;

  HidePhoneField(this.createStore);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          Observer(
            builder: (_) {
              return Checkbox(
                value: createStore.hidePhone ?? false,
                onChanged: createStore.setPhone,
              );
            },
          ),
          Expanded(child: Text('Ocultar o meu telefone neste anuncio.')),
        ],
      ),
    );
  }
}
