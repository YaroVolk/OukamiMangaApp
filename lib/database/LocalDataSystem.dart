import 'dart:io';

import 'package:Oukami/bloc/BlocDownload.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:Oukami/bloc/BlocChapter.dart';
import 'package:Oukami/bloc/BlocFavorite.dart';
import 'package:path_provider/path_provider.dart';

class LocalDataSystem {
  Future<void> initData(context) async {
    var db = Hive.box('komikcast');
    // var db = Hive.box('komikcast');

    this.historyInit(db: db);
    this.favoriteInit(db: db);
    this.chapterReadedInit(db: db);
    this.downloadsInit();

    Modular.to.pushReplacementNamed('/main');
  }

  void historyInit({Box db}) {
    List historyList = db.get('history') == null ? [] : db.get('history');
    Modular.get<BlocHistory>().add(historyList.cast<Map>());
  }

  void chapterReadedInit({Box db}) {
    List chapterReadedList =
        db.get('chapterReaded') == null ? [] : db.get('chapterReaded');
    Modular.get<BlocChapter>().add(chapterReadedList.cast<String>());
  }

  void favoriteInit({Box db}) {
    List favoriteList = db.get('favorite') == null ? [] : db.get('favorite');
    Modular.get<BlocFavorite>().add(favoriteList.cast<Map>());
  }

  void downloadsInit() async {
    final directory = (await getExternalStorageDirectory()).path;
    List<Map> tempAll = [];
    List<Map> allChapter = [];

    Directory(directory).listSync().forEach((element) {
      var tempComicFolder = {};

      tempComicFolder['title'] = element.path
          .replaceAll('$directory/', '')
          .split('-')
          .map((e) => e[0].toUpperCase() + e.substring(1))
          .join(' ');

      tempComicFolder['mangaId'] = element.path.replaceAll('$directory/', '');
      tempComicFolder['folderPath'] = element.path;

      var chapterFolder = Directory(element.path).listSync();
      chapterFolder = chapterFolder
          .where((element) =>
              element.path.contains('cover.jpg') == false &&
              element.path.contains('cover.jpeg') == false &&
              element.path.contains('cover.png') == false &&
              element.path.contains('detail.txt') == false)
          .toList();

      for (var i = 0; i < chapterFolder.length; i++) {
        var tempChapter = {};
        tempChapter['chapterId'] =
            chapterFolder[i].path.replaceAll(element.path, '');
        tempChapter['chapterIdPath'] = chapterFolder[i].path;
        tempChapter['images'] = Directory(chapterFolder[i].path)
            .listSync()
            .map((e) => e.path)
            .toList()
            .cast<String>();

        allChapter.add(tempChapter);
      }

      var detailFolder = Directory(element.path).listSync();
      detailFolder = detailFolder
          .where((element) =>
              element.path.contains('cover.jpg') ||
              element.path.contains('cover.jpeg') ||
              element.path.contains('cover.png') ||
              element.path.contains('detail.txt'))
          .toList();

      var imageThumbnail = detailFolder[0].path;

      var detailTxtPath = detailFolder.last.path;

      String author;

      try {
        final File file = File(detailTxtPath);
        author = file.readAsStringSync();
      } catch (e) {}

      tempComicFolder['imagePath'] = imageThumbnail;
      tempComicFolder['author'] = author;
      tempComicFolder['dateModified'] = DateFormat('d MMMM yyyy')
          .format(Directory(element.path).listSync().last.statSync().modified);
      tempAll.add(tempComicFolder);
    });

    Modular.get<BlocDownloadAlredy>().add(tempAll);
    Modular.get<BlocDownloadedChapter>().add(allChapter);
  }

  void downloadPermInit({Box db, bool isPro = false}) {
    if (isPro == false) db.put('is_download_permanent', false);
    Modular.get<BlocDownloadSetting>()
        .add(db.get('is_download_permanent', defaultValue: false));
  }
}
