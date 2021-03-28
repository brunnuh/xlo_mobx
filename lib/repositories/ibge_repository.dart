import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xlo_mobx/models/city.dart';
import 'package:xlo_mobx/models/uf.dart';

class IBGERepository {
  String url = 'https://servicodados.ibge.gov.br/api/v1/localidades/estados';
  Dio dio = Dio();

  Future<List<UF>> getUFList() async {
    final preferences = await SharedPreferences.getInstance();

    if (preferences.containsKey('UF_LIST')) {
      //cache

      final j = json.decode(preferences.get('UF_LIST'));
      return j.map<UF>((j) => UF.fromJson(j)).toList()
        ..sort((UF a, UF b) =>
            a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    }

    try {
      final Response response = await dio.get<List>(url);

      preferences.setString('UF_LIST', json.encode(response.data));

      final ufList = response.data.map<UF>((j) => UF.fromJson(j)).toList()
        ..sort((UF a, UF b) =>
            a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      return ufList;
    } on DioError {
      return Future.error('Falha ao obter lista de estados');
    }
  }

  Future<List<City>> getCityListFromApi(UF uf) async {
    try {
      final Response response = await dio.get(url + '/${uf.id}/municipios');

      final cityList = response.data.map<City>((j) => City.fromJson(j)).toList()
        ..sort((City a, City b) =>
            a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      return cityList;
    } on DioError {
      return Future.error('Falha ao obter lista de cidades');
    }
  }
}
