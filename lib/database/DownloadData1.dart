import 'dart:io';

import 'package:Oukami/database/ChapterManga.dart';
import 'package:Oukami/database/MangaData.dart';
import 'package:Oukami/models/DetailManga.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Oukami/bloc/BlocDownload.dart';
import 'package:Oukami/models/download_status.dart';
import 'package:Oukami/database/LocalDataSystem.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DownloadData {
  void downloadChapter({
    BuildContext context,
    DetailManga data,
    List<ChapterListDetail> listData,
    Function onComplete,
  }) async {
    if (data.chapterList.length == 0)
      Modular.to.pop(context);
    else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => BlocBuilder<BlocDownload, DownloadStatus>(
          builder: (context, state) => WillPopScope(
            onWillPop: () async {
              return state.percent == 100;
            },
            child: AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Downloading...'),
                      Text('${state.currentIndex}/${state.total}'),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    child: LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width * .64,
                      lineHeight: 10.0,
                      percent: state.percent / 100,
                      backgroundColor: Colors.grey.withOpacity(.5),
                      progressColor: Colors.lightBlue,
                      animation: false,
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ),
      );
      downloadFiles(
        data: listData,
        context: context,
        author: data.author,
        imageDetail: data.image,
        callback: onComplete,
      );
    }
  }

  void downloadFiles({
    List<ChapterListDetail> data,
    BuildContext context,
    int index = 0,
    String imageDetail,
    String author,
    Function callback,
  }) async {
    Dio dio = Dio();
    var appDir = await getExternalStorageDirectory();

    int totalImage = 0;
    int imageDownloaded = 0;
    // ignore: unused_local_variable
    for (var item in data) {
      ChapterManga detail =
          await MangaData.getChapterManga(id: data[0].chapter_endpoint);
      // ignore: unused_local_variable
      for (var image in detail.images) {
        totalImage++;
      }
    }

    try {
      for (var item in data) {
        ChapterManga detail =
            await MangaData.getChapterManga(id: data[0].chapter_endpoint);
        for (var image in detail.images) {
          var savePath = appDir.path.toString() +
              '/' +
              detail.comicLinkId +
              '/' +
              item.chapter_endpoint +
              image.link.split('/').last;
          var downloadPath = image.link;

          await dio.download(downloadPath, savePath,
              onReceiveProgress: (rec, total) async {
            var percent = ((rec / total) * 100);

            if (percent.toInt() == 100) {
              imageDownloaded += 1;
            }

            Modular.get<BlocDownload>().add(
              DownloadStatus(
                currentIndex: data.indexOf(item) + 1,
                total: data.length,
                percent: ((imageDownloaded / totalImage) * 100).toInt(),
              ),
            );

            if (imageDownloaded == totalImage) {
              callback();

              Future.delayed(Duration(milliseconds: 1500), () {
                Navigator.pop(context);
                Future.delayed(Duration(milliseconds: 1000), () {
                  Modular.get<BlocDownload>().add(
                    DownloadStatus(currentIndex: 0, total: 0, percent: 0),
                  );
                });
              });

              await dio.download(
                  imageDetail,
                  appDir.path.toString() +
                      '/' +
                      detail.comicLinkId +
                      '/cover.' +
                      imageDetail.split('/').last.split('.').last);

              final File file = File(appDir.path.toString() +
                  '/' +
                  detail.comicLinkId +
                  '/' +
                  'detail.txt');
              file.writeAsStringSync('$author');

              LocalDataSystem().downloadsInit();
            }
          });
        }
      }
    } catch (e) {}
  }
}
