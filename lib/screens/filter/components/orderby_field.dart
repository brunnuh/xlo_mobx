import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/screens/filter/components/section_title.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

class OrderByField extends StatelessWidget {
  final FilterStore filterStore = GetIt.I<FilterStore>();

  @override
  Widget build(BuildContext context) {
    Widget buildOption(String title, OrderBy option) {
      return GestureDetector(
        onTap: () {
          filterStore.setOrderBy(option);
        },
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          decoration: BoxDecoration(
            border: filterStore.orderBy != option
                ? Border.all(
                    color: Colors.grey,
                  )
                : null,
            borderRadius: BorderRadius.circular(25),
            color: filterStore.orderBy == option
                ? Colors.purple
                : Colors.transparent,
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color:
                    filterStore.orderBy == option ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: 'Ordenar por',
        ),
        Observer(
          builder: (_) => Row(
            children: [
              buildOption('Data', OrderBy.DATE),
              const SizedBox(
                width: 12,
              ),
              buildOption('Preço', OrderBy.PRICE),
            ],
          ),
        )
      ],
    );
  }
}
