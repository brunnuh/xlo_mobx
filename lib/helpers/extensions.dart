import 'package:intl/intl.dart';

extension StringExtension on String {
  bool isEmailValid() {
    final RegExp regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regex.hasMatch(this);
  }
}

extension NumberExtension on num {
  String formattedMoney({bool siflao = true}) {
    return NumberFormat((siflao ? 'R\$' : '') + '###,##0.00', 'pt-BR')
        .format(this);
  }
}

extension DateTimeExtension on DateTime {
  String formattedDate() {
    return DateFormat('dd/MM/yyyy HH:mm', 'pt-BR').format(this);
  }
}
