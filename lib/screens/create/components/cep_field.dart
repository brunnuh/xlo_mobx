import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/stores/cep_store.dart';

class CepField extends StatelessWidget {
  final CepStore cepStore = CepStore();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          onChanged: cepStore.setCep,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CepInputFormatter()
          ],
          enabled: !cepStore.loading,
          decoration: InputDecoration(
            icon: cepStore.loading ? CircularProgressIndicator() : null,
            labelText: 'CEP *',
            labelStyle: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.grey,
              fontSize: 18,
            ),
            errorText: cepStore.error,
            contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
          ),
        ),
        Observer(
          builder: (_) {
            if (cepStore.address == null &&
                cepStore.error == null &&
                !cepStore.loading) {
              return Container();
            } else if (cepStore.address == null && cepStore.error == null) {
              return LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.purple),
                backgroundColor: Colors.transparent,
              );
            } else if (cepStore.error != null) {
              return Container(
                color: Colors.red.withAlpha(100),
                height: 50,
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    cepStore.error,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                ),
              );
            } else {
              final a = cepStore.address;
              return Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.purple.withAlpha(150),
                height: 50,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Localização: ${a.district}, ${a.city.name} - ${a.uf.initials}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.fade,
                ),
              );
            }
          },
        )
      ],
    );
  }
}
