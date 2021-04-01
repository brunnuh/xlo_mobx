import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/stores/create_store.dart';

import 'components/category_field.dart';
import 'components/cep_field.dart';
import 'components/hide_phone_field.dart';
import 'components/images_field.dart';

class CreateScreen extends StatelessWidget {
  final labelStyle = TextStyle(
    fontWeight: FontWeight.w800,
    color: Colors.grey,
    fontSize: 18,
  );

  final contentPadding = EdgeInsets.fromLTRB(16, 10, 12, 10);

  final CreateStore createStore = CreateStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Anúncio'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Card(
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.symmetric(horizontal: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                ImagesField(createStore),
                Observer(
                  builder: (_) {
                    return TextFormField(
                      onChanged: createStore.setTitle,
                      decoration: InputDecoration(
                        labelText: "Titulo *",
                        labelStyle: labelStyle,
                        contentPadding: contentPadding,
                        errorText: createStore.titleError,
                      ),
                    );
                  },
                ),
                Observer(
                  builder: (_) {
                    return TextFormField(
                      onChanged: createStore.setDecription,
                      decoration: InputDecoration(
                        labelText: "Descrição *",
                        labelStyle: labelStyle,
                        contentPadding: contentPadding,
                        errorText: createStore.descriptionError,
                      ),
                      maxLines: null,
                    );
                  },
                ),
                CategoryField(createStore),
                CepField(createStore),
                Observer(
                  builder: (_) {
                    return TextFormField(
                      onChanged: createStore.setPrice,
                      decoration: InputDecoration(
                        labelText: "Preço *",
                        labelStyle: labelStyle,
                        contentPadding: contentPadding,
                        prefixText: 'R\$ ',
                        errorText: createStore.priceError,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        RealInputFormatter(centavos: true),
                      ],
                    );
                  },
                ),
                HidePhoneField(createStore),
                Container(
                  height: 50,
                  child: Observer(
                    builder: (_) {
                      return GestureDetector(
                        onTap: createStore
                            .invalidSendPressed, // se botao estiver desabilitado
                        child: ElevatedButton(
                          child: Text(
                            'Enviar',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: createStore.sendPressed, //botao habilitado
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => Colors.orange),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      drawer: CustomDrawer(),
    );
  }
}
