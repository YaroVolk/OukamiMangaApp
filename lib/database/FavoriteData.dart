import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:Oukami/bloc/BlocFavorite.dart';

class FavoriteData {
  static saveFavorite({
    String mangaId,
    String currentId,
    String detailChapter,
    String image,
    String title,
    String type,
    BuildContext context,
  }) {
    var db = Hive.box('komikcast');
    // var db = Hive.box('Oukami');

    {
      List listFavorite = db.get('favorite') != null ? db.get('favorite') : [];
      listFavorite = listFavorite.cast<Map>();

      var favorite = {
        'image': image,
        'title': title,
        'mangaId': mangaId.substring(mangaId.length - 1) == '/'
            ? mangaId.replaceAll('/', '')
            : mangaId,
        'chapterId': currentId,
        'chapterName': detailChapter,
        'type': type,
      };

      listFavorite.add(favorite);
      db.put('favorite', listFavorite);

      Modular.get<BlocFavorite>().add(listFavorite);

      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Ditambahkan ke Favorit')));
    }
  }

  static unsaveFavorite({
    String mangaId,
  }) {
    var db = Hive.box('komikcast');

    List listFavorite = db.get('favorite') != null ? db.get('favorite') : [];
    listFavorite = listFavorite.cast<Map>();

    listFavorite = listFavorite
        .where(
          (element) =>
              element['mangaId'] !=
              (mangaId.substring(mangaId.length - 1) == '/'
                  ? mangaId.replaceAll('/', '')
                  : mangaId),
        )
        .toList();
    listFavorite = listFavorite.cast<Map>();

    db.put('favorite', listFavorite);

    Modular.get<BlocFavorite>().add(listFavorite);
  }
}
