import 'dart:io';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:path/path.dart' as path;
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/parse_errors.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

class AdRepository {
  Future<void> save(Ad ad) async {
    try {
      final parseImages = await saveImages(ad.images);

      final parseUser = ParseUser('', '', '')
        ..set(keyUserId,
            ad.user.id); // criando um tipo parse apartir do objeto user

      final adObject =
          ParseObject(keyAdTable); // criando objeto da table de anuncio

      // regras
      final parseAcl = ParseACL(owner: parseUser);
      parseAcl.setPublicReadAccess(allowed: true); // so podem ler o anuncio
      parseAcl.setPublicWriteAccess(
          allowed: false); // ninguem alem do usurio pode escrever

      // add no objeto anuncio
      adObject.setACL(parseAcl);

      // add obj ad no obj da table do parse
      adObject.set<String>(keyAdTitle, ad.title);
      adObject.set<String>(keyAdDescription, ad.description);
      adObject.set<bool>(keyAdHidePhone, ad.hidePhone);
      adObject.set<num>(keyAdPrice, ad.price);
      adObject.set<int>(keyAdStatus, ad.status.index);
      adObject.set<String>(keyAdDistrict, ad.address.district);
      adObject.set<String>(keyAdCity, ad.address.city.name);
      adObject.set<String>(keyAdFederativeUnit, ad.address.uf.initials);
      adObject.set<String>(keyAdPostalCode, ad.address.cep);
      adObject.set<List<ParseFile>>(keyAdImages, parseImages);
      adObject.set<ParseUser>(keyAdOwner, parseUser);
      adObject.set<ParseObject>(
          keyAdCategory,
          ParseObject(keyCategoryTable)
            ..set(keyCategoryId,
                ad.category.id)); //relacao entre categoria e objeto anuncio

      // salvando
      final response = await adObject.save();
      if (!response.success) {
        return Future.error(ParseErrors.getDescription(response.error.code));
      }
    } catch (e) {
      return Future.error('Falha ao salvar anuncio.');
    }
  }

  Future<List<ParseFile>> saveImages(List images) async {
    final parseImages = <ParseFile>[];

    try {
      for (final image in images) {
        if (image is File) {
          // se for um arquivo
          final parseFile = ParseFile(image, name: path.basename(image.path));
          final response = await parseFile.save();
          if (!response.success) {
            return Future.error(ParseErrors.getDescription(response
                .error.code)); // converti o codigo em uma descricao de texto
          }
          parseImages.add(parseFile);
        } else {
          // se for uma url
          final parseFile = ParseFile(null);
          parseFile.name = path.basename(image);
          parseFile.url = image;
          parseImages.add(parseFile);
        }
      }
    } catch (e) {
      return Future.error('Falha ao salvar imagen(s)');
    }
    return parseImages;
  }

  Future<List<Ad>> getHomeAdList({
    FilterStore filter,
    String search,
    Category category,
    int page,
  }) async {
    final queryBuilder = QueryBuilder<ParseObject>(ParseObject(keyAdTable));

    queryBuilder.includeObject(
        [keyAdOwner, keyAdCategory]); // para trazer as seguintes tables

    queryBuilder
        .setAmountToSkip(page * 10); // pular o numero de paginas ja carregadas
    queryBuilder.setLimit(10); // somente 20 anuncios

    queryBuilder.whereEqualTo(
        keyAdStatus, AdStatus.ACTIVE.index); // somente anuncios ativos

    if (search != null && search.trim().isNotEmpty) {
      // buscando pelo titulo do ad
      queryBuilder.whereContains(keyAdTitle, search, caseSensitive: false);
    }
    if (category != null && category.id != "*") {
      // busca pela categoria do anuncio
      queryBuilder.whereEqualTo(
        keyAdCategory,
        (ParseObject(keyCategoryTable)..set(keyCategoryId, category.id))
            .toPointer(),
      );
    }

    switch (filter.orderBy) {
      case OrderBy.PRICE:
        // ordenar pelo preço
        queryBuilder.orderByAscending(keyAdPrice);
        break;
      case OrderBy.DATE:
      default:
        // ordernar pela data
        queryBuilder.orderByDescending(keyAdCreatedAt);
        break;
    }

    if (filter.minPrice != null && filter.minPrice > 0) {
      // busca pelo valor maior ou igual a minprice
      queryBuilder.whereGreaterThanOrEqualsTo(keyAdPrice, filter.minPrice);
    }

    if (filter.maxPrice != null && filter.maxPrice > 0) {
      // busca pelo valor menor ou igual a maxprice
      queryBuilder.whereLessThanOrEqualTo(keyAdPrice, filter.maxPrice);
    }
    if (filter.vendorType != null &&
        filter.vendorType > 0 &&
        filter.vendorType <
            (VENDOR_TYPE_PARTICULAR | VENDOR_TYPE_PROFESSIONAL)) {
      // subquery do usuario
      final userQuery = QueryBuilder<ParseUser>(ParseUser.forQuery());
      if (filter.vendorType == VENDOR_TYPE_PARTICULAR) {
        // buscando os usuarios particulares
        userQuery.whereEqualTo(keyUserType, UserType.PARTICULAR.index);
      }
      if (filter.vendorType == VENDOR_TYPE_PROFESSIONAL) {
        // buscando os usuarios profissional
        userQuery.whereEqualTo(keyUserType, UserType.PROFESSIONAL.index);
      }

      // query do filtro
      // onde vai verificar se combina a query do filtro com a do usuario e retornar somente elas
      queryBuilder.whereMatchesQuery(keyAdOwner, userQuery);
    }
    final response = await queryBuilder.query();
    if (response.success && response.results != null) {
      return response.results.map((e) => Ad.fromParse(e)).toList();
    } else if (response.success && response.results == null) {
      return [];
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }
}
