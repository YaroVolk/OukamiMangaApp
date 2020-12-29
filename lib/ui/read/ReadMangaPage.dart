import 'dart:io';

import 'package:Oukami/ui/read/BottomMenu.dart';
import 'package:Oukami/ui/read/ContentPage.dart';
import 'package:Oukami/ui/read/HeaderMenu.dart';
import 'package:flutter/material.dart';
import 'package:Oukami/database/ChapterReadedData.dart';
import 'package:Oukami/database/comic_data.dart';
import 'package:Oukami/database/HistoryData.dart';
import 'package:Oukami/models/detail_chapter.dart';
import 'package:Oukami/models/detail_comic.dart';

class ReadMangaPage extends StatefulWidget {
  final String mangaId, currentId;
  final Map downloadData;

  ReadMangaPage({
    this.mangaId,
    this.currentId,
    this.downloadData,
  });

  @override
  _ReadMangaPageState createState() => _ReadMangaPageState();
}

class _ReadMangaPageState extends State<ReadMangaPage> {
  var showMenu = false;
  var mangaId, currentId;
  var isLoaded = false;
  String nextId, prevId, currentChapter;
  List<SelectChapter> listChapter = [];
  List<ImageChapter> listImage = [];
  DetailComic detail;
  Map downloadData;

  @override
  void initState() {
    super.initState();
    mangaId = widget.mangaId;
    currentId = widget.currentId;
    downloadData = widget.downloadData;

    if (downloadData == null)
      getListData(withDetail: true);
    else
      getDownloadedData(
        title: downloadData['title'],
        path: downloadData['downloadPath'],
      );
  }

  getDownloadedData({String path, String title}) {
    setState(() {
      downloadData['images'] =
          Directory(path).listSync().map((e) => e.path).toList().cast<String>();
      isLoaded = true;
    });
  }

  getListData({withDetail = false}) async {
    if (withDetail == true)
      detail = await ComicData.getDetailKomik(id: mangaId);

    final res = await ComicData.getChapterKomik(id: currentId);
    listChapter = res.selectChapter;
    listImage = res.images;

    prevId = res.prevLinkId;
    nextId = res.nextLinkId;
    currentChapter = res.chapter;

    if (this.mounted)
      setState(() {
        isLoaded = true;
      });

    ChapterReadedData.saveChapter(chapterId: currentId);

    return HistoryData.saveHistory(
        mangaId: mangaId, currentId: currentId, detailChapter: res);
  }

  changeChapter({id}) {
    if (this.mounted) {
      setState(() {
        currentId = id;
        isLoaded = false;

        getListData();
      });
    }
  }

  setShowMenu(bool state) {
    setState(() {
      showMenu = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        child: Stack(
          children: [
            isLoaded
                ? ContentPage(
                    setShowMenu: setShowMenu,
                    showMenu: showMenu,
                    images: listImage,
                    downloadedImages:
                        downloadData == null ? null : downloadData['images'],
                  )
                : Positioned.fill(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
            HeaderMenu(
              width: width,
              showMenu: showMenu,
              currentChapter: currentChapter,
              titleDownloaded:
                  downloadData == null ? null : downloadData['title'],
              rootContext: context,
              listChapter: listChapter,
              changeChapter: changeChapter,
            ),
            downloadData == null
                ? BottomMenu(
                    width: width,
                    showMenu: showMenu,
                    nextId: nextId,
                    prevId: prevId,
                    changeChapter: changeChapter,
                    isLoaded: isLoaded,
                    mangaId: mangaId,
                    detail: detail,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
