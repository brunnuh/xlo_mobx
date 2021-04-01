import 'dart:io';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:path/path.dart' as path;
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/repositories/parse_errors.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';

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
}
