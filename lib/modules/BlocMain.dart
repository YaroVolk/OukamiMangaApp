import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Oukami/bloc/BlocChapter.dart';
import 'package:Oukami/bloc/BlocDownload.dart';
import 'package:Oukami/bloc/BlocFavorite.dart';
import 'package:Oukami/bloc/BlocWidget.dart';

class BlocMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BlocWidget>(create: (context) => Modular.get<BlocWidget>()),
        BlocProvider<BlocSliver>(
            create: (context) => Modular.get<BlocSliver>()),
        BlocProvider<BlocBlur>(create: (context) => Modular.get<BlocBlur>()),
        BlocProvider<BlocScroll>(
            create: (context) => Modular.get<BlocScroll>()),
        BlocProvider<BlocChapterReverse>(
            create: (context) => Modular.get<BlocChapterReverse>()),
        BlocProvider<BlocHistory>(
            create: (context) => Modular.get<BlocHistory>()),
        BlocProvider<BlocFavorite>(
            create: (context) => Modular.get<BlocFavorite>()),
        BlocProvider<BlocChapter>(
            create: (context) => Modular.get<BlocChapter>()),
        BlocProvider<BlocDownload>(
            create: (context) => Modular.get<BlocDownload>()),
        BlocProvider<BlocDownloadAlredy>(
            create: (context) => Modular.get<BlocDownloadAlredy>()),
        BlocProvider<BlocDownloadedChapter>(
            create: (context) => Modular.get<BlocDownloadedChapter>()),
        BlocProvider<BlocDownloadSetting>(
            create: (context) => Modular.get<BlocDownloadSetting>()),
        BlocProvider<BlocFavoriteSort>(
            create: (context) => Modular.get<BlocFavoriteSort>()),
      ],
      child: BlocBuilder<BlocWidget, ThemeMode>(
        builder: (context, currentTheme) => MaterialApp(
          initialRoute: "/",
          onGenerateRoute: Modular.generateRoute,
          navigatorKey: Modular.navigatorKey,
          themeMode: currentTheme,
          theme: CustomTheme.lightTheme,
        ),
      ),
    );
  }
}

class CustomTheme {
  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        textSelectionColor: Colors.white,
        textSelectionHandleColor: Colors.black,
      );
}
