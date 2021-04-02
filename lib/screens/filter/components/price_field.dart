import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PriceField extends StatelessWidget {
  final String label;
  final Function(int) onChanged;
  final int initialValue;

  PriceField({this.label, this.onChanged, this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        onChanged: (text) {
          onChanged(int.tryParse(text.replaceAll('.', '')));
        },
        decoration: InputDecoration(
          prefixText: 'R\$ ',
          border: OutlineInputBorder(),
          isDense: true,
          labelText: label,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          RealInputFormatter(centavos: false),
        ],
        initialValue: initialValue?.toString(),
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontSize: 13,
        ),
      ),
    );
  }
}
