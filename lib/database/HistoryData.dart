import 'package:Oukami/bloc/BlocFavorite.dart';
import 'package:Oukami/database/ComicData.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:Oukami/models/detail_chapter.dart';

class HistoryData {
  static saveHistory({
    String mangaId,
    String currentId,
    DetailChapter detailChapter,
  }) async {
    var db = Hive.box('komikcast');

    List listHistory = db.get('history') != null ? db.get('history') : [];
    listHistory = listHistory.cast<Map>();

    var comicData = await ComicData.getDetailKomik(id: mangaId);

    var history = {
      'image': comicData.image,
      'title': comicData.title,
      'mangaId': mangaId,
      'chapterId': currentId,
      'chapterName': detailChapter.chapter,
    };

    listHistory = listHistory
        .where((element) => element['chapterId'] != currentId)
        .toList();

    listHistory.add(history);
    db.put('history', listHistory);

    Modular.get<BlocHistory>().add(listHistory);
  }
}
