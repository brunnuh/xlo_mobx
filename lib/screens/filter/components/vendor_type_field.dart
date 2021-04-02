import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/screens/filter/components/section_title.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

class VendorTypeField extends StatelessWidget {
  final FilterStore filterStore = GetIt.I<FilterStore>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: 'Tipo de anunciante'),
        Observer(builder: (_) {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Wrap(
              runSpacing: 4,
              alignment: WrapAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (filterStore.isTypeParticular) {
                      if (filterStore.isTypeProfessional)
                        filterStore.resetVendorType(VENDOR_TYPE_PARTICULAR);
                      else
                        filterStore.selectVendorType(VENDOR_TYPE_PROFESSIONAL);
                    } else {
                      filterStore.setVendorType(VENDOR_TYPE_PARTICULAR);
                    }
                  },
                  child: Container(
                    width: 130,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: filterStore.isTypeParticular
                          ? Colors.purple
                          : Colors.transparent,
                      border: filterStore.isTypeParticular
                          ? null
                          : Border.all(
                              color: Colors.grey,
                            ),
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Particular',
                      style: TextStyle(
                        color: filterStore.isTypeParticular
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    if (filterStore.isTypeProfessional) {
                      if (filterStore.isTypeParticular)
                        filterStore.resetVendorType(VENDOR_TYPE_PROFESSIONAL);
                      else
                        filterStore.selectVendorType(VENDOR_TYPE_PARTICULAR);
                    } else {
                      filterStore.setVendorType(VENDOR_TYPE_PROFESSIONAL);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: filterStore.isTypeProfessional
                          ? Colors.purple
                          : Colors.transparent,
                      border: filterStore.isTypeProfessional
                          ? null
                          : Border.all(
                              color: Colors.grey,
                            ),
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Profissional',
                      style: TextStyle(
                        color: filterStore.isTypeProfessional
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        })
      ],
    );
  }
}
