import 'package:dio/dio.dart';
import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/models/city.dart';
import 'package:xlo_mobx/repositories/ibge_repository.dart';

class CepRepository {
  Dio dio = Dio();
  final url = 'http://viacep.com.br/ws';

  Future<Address> getAddressFromApi(String cep) async {
    if (cep == null || cep.isEmpty) {
      return Future.error('CEP Inválido');
    }
    final clearCep = cep.replaceAll(RegExp("[^0-9]"), '');

    if (clearCep.length != 8) {
      return Future.error('CEP Inválido');
    }

    try {
      final response = await dio.get(url + "/${clearCep}/json");

      if (response.data.containsKey('erro') && response.data['erro']) {
        return Future.error('CEP Inválido');
      }

      final ufList = await IBGERepository().getUFList();

      return Address(
        cep: response.data['cep'],
        district: response.data['bairro'],
        city: City(name: response.data['localidade']),
        uf: ufList.firstWhere((uf) => uf.initials == response.data['uf']),
      );
    } catch (e) {
      return Future.error('Falha ao buscar cep');
    }
  }
}
