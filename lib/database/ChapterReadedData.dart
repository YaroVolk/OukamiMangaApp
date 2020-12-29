import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:Oukami/bloc/BlocChapter.dart';

class ChapterReadedData {
  static saveChapter({String chapterId}) {
    var db = Hive.box('Oukami');

    List listChapterReaded =
        db.get('chapterReaded') != null ? db.get('chapterReaded') : [];
    listChapterReaded = listChapterReaded.cast<String>();

    if (listChapterReaded.indexOf(chapterId) >= 0) {
      listChapterReaded.removeAt(listChapterReaded.indexOf(chapterId));
    }

    listChapterReaded.add(chapterId);
    db.put('chapterReaded', listChapterReaded);

    Modular.get<BlocChapter>().add(listChapterReaded);
  }
}
