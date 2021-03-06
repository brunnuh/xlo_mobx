import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/components/error_box.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/screens/myads/my_ads_screen.dart';
import 'package:xlo_mobx/stores/create_store.dart';
import 'package:xlo_mobx/stores/page_store.dart';

import 'components/category_field.dart';
import 'components/cep_field.dart';
import 'components/hide_phone_field.dart';
import 'components/images_field.dart';

class CreateScreen extends StatefulWidget {
  CreateScreen({this.ad});

  final Ad ad;

  @override
  _CreateScreenState createState() => _CreateScreenState(ad);
}

class _CreateScreenState extends State<CreateScreen> {
  _CreateScreenState(Ad ad)
      : editing = ad != null,
        createStore = CreateStore(ad ?? Ad());

  bool editing;

  final CreateStore createStore;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*reaction((_) => createStore.savedAd, (ad) {
      if(ad != null){

      }
    });*/
    when((_) => createStore.savedAd, () {
      if (editing)
        Navigator.of(context).pop(true);
      // chamado somente uma vez
      else {
        GetIt.I<PageStore>().setPage(
            0); //caso tenha alguma mudanca no savedAd, ir para pagina inicial
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => MyAdsScreen(initialPage: 1)),
        );
      }
    });
  }

  final labelStyle = TextStyle(
    fontWeight: FontWeight.w800,
    color: Colors.grey,
    fontSize: 18,
  );

  final contentPadding = EdgeInsets.fromLTRB(16, 10, 12, 10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editing ? 'Editar An??ncio' : 'Criar An??ncio'),
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
            child: Observer(
              builder: (_) => createStore.loading
                  ? Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            'Salvando Anuncio',
                            style: TextStyle(
                              color: Colors.purple,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.purple),
                          )
                        ],
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ImagesField(createStore),
                        Observer(
                          builder: (_) {
                            return TextFormField(
                              initialValue: createStore.title,
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
                              initialValue: createStore.description,
                              onChanged: createStore.setDecription,
                              decoration: InputDecoration(
                                labelText: "Descri????o *",
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
                              initialValue: createStore.priceText,
                              onChanged: createStore.setPrice,
                              decoration: InputDecoration(
                                labelText: "Pre??o *",
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
                        Observer(
                          builder: (_) => ErrorBox(
                            message: createStore.error,
                          ),
                        ),
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
                                  onPressed: createStore
                                      .sendPressed, //botao habilitado
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => Colors.orange),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
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
      ),
      drawer: editing ? null : CustomDrawer(),
    );
  }
}

/**/
