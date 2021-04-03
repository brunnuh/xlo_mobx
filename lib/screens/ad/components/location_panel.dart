import 'package:flutter/material.dart';
import 'package:xlo_mobx/models/ad.dart';

class LocationPanel extends StatelessWidget {
  Ad ad;

  LocationPanel(this.ad);

  @override
  Widget build(BuildContext context) {
    Widget fieldLocation(String title, String child) {
      return Row(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                child,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Localização',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        fieldLocation('CEP', ad.address.cep),
        fieldLocation('Município', ad.address.city.name),
        fieldLocation('Bairro', ad.address.district),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
