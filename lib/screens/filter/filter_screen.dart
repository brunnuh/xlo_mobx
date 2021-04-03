import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/screens/filter/components/price_range_field.dart';
import 'package:xlo_mobx/screens/filter/components/vendor_type_field.dart';
import 'package:xlo_mobx/stores/filter_store.dart';
import 'package:xlo_mobx/stores/home_store.dart';

import 'components/orderby_field.dart';

class FilterScreen extends StatelessWidget {
  final FilterStore filterStore = GetIt.I<HomeStore>().cloneFilter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtrar busca'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 32),
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: Text(
                      'Localização',
                      style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  OrderByField(filterStore: filterStore),
                  PriceRangeField(filterStore: filterStore),
                  VendorTypeField(filterStore: filterStore),
                  Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: Observer(
                      builder: (_) {
                        return ElevatedButton(
                          onPressed: filterStore.ifFormValid
                              ? () {
                                  filterStore.save();
                                  Navigator.of(context).pop();
                                }
                              : null,
                          child: Text('Filtrar'),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            foregroundColor: MaterialStateProperty.all(
                              Colors.white,
                            ),
                            backgroundColor: MaterialStateProperty.all(
                              filterStore.ifFormValid
                                  ? Colors.orange
                                  : Colors.grey,
                            ),
                            textStyle: MaterialStateProperty.all(
                              TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
