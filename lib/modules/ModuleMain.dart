import 'package:Oukami/ui/download/DownloadPage.dart';
import 'package:Oukami/ui/pages/libary/DownloadedChapterScreen.dart';
import 'package:Oukami/ui/read/ChapterPage.dart';
import 'package:Oukami/modules/BlocMain.dart';
import 'package:Oukami/ui/detail/DetailPage.dart';
import 'package:Oukami/ui/main/MainPage.dart';
import 'package:Oukami/ui/read/ReadMangaPage.dart';
import 'package:Oukami/ui/sub/SearchTab.dart';
import 'package:Oukami/ui/sub/SubPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Oukami/bloc/BlocChapter.dart';
import 'package:Oukami/bloc/BlocDownload.dart';
import 'package:Oukami/bloc/BlocFavorite.dart';
import 'package:Oukami/bloc/BlocWidget.dart';
import 'package:Oukami/ui/main/MainSettingPage.dart';
import 'package:Oukami/ui/main/SplashScreen.dart';

class ModuleMain extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((_) => BlocWidget()),
        Bind((_) => BlocSliver()),
        Bind((_) => BlocBlur()),
        Bind((_) => BlocScroll()),
        Bind((_) => BlocChapterReverse()),
        Bind((_) => BlocHistory()),
        Bind((_) => BlocFavorite()),
        Bind((_) => BlocChapter()),
        Bind((_) => BlocDownload()),
        Bind((_) => BlocDownloadAlredy()),
        Bind((_) => BlocDownloadedChapter()),
        Bind((_) => BlocDownloadSetting()),
        Bind((_) => BlocFavoriteSort()),
      ];

  @override
  List<Router> get routers => [
        Router(
          '/',
          child: (_, args) => SplashPage(),
        ),
        Router(
          '/main',
          child: (_, args) => MainPage(),
          transition: TransitionType.rightToLeftWithFade,
        ),
        Router(
          '/search',
          child: (_, args) => SearchTab(),
          transition: TransitionType.rightToLeftWithFade,
        ),
        Router(
          '/setting',
          child: (_, args) => MainSettingPage(),
        ),
        Router(
          '/detailmanga',
          child: (_, args) => DetailPage(
            image: args.data['image'],
            title: args.data['title'],
            manga_endpoint: args.data['manga_endpoint'],
          ),
        ),
        Router(
          '/downloadmanga',
          child: (_, args) => DownloadPage(
            detail: args.data['detail'],
          ),
        ),
        Router(
          '/readmanga',
          child: (_, args) => ReadMangaPage(
            mangaId: args.data['mangaId'],
            currentId: args.data['currentId'],
            downloadData: args.data['downloadData'],
          ),
          transition: TransitionType.rightToLeft,
        ),
        Router(
          '/readchapter',
          child: (_, args) => ChapterPage(
            mangaId: args.data['mangaId'],
            currentId: args.data['currentId'],
            downloadData: args.data['downloadData'],
          ),
          transition: TransitionType.rightToLeft,
        ),
        Router(
          '/downloadedchapter',
          child: (_, args) => DownloadedChapterScreen(
            title: args.data['title'],
            folderPath: args.data['folderPath'],
          ),
        ),
        Router(
          '/homeother',
          child: (_, args) => SubPage(
            appBarTitle: args.data['title'],
          ),
        ),
      ];

  @override
  Widget get bootstrap => BlocMain();
}
