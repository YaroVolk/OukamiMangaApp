import 'package:Oukami/bloc/BlocWidget.dart';
import 'package:Oukami/models/DetailManga.dart';
import 'package:Oukami/ui/detail/DetailTab/TabOverview1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ContentManga extends StatefulWidget {
  ContentManga({
    Key key,
    @required this.width,
    this.detail,
    this.mangaId,
  }) : super(key: key);

  final double width;
  final DetailManga detail;
  final String mangaId;

  @override
  _ContentMangaState createState() => _ContentMangaState();
}

class _ContentMangaState extends State<ContentManga> {
  var index = 0;
  var widgetList = [];

  @override
  void initState() {
    super.initState();
    widgetList = [
      TabOverview(
        detail: widget.detail,
        mangaId: widget.mangaId,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, state) {
        index = DefaultTabController.of(context).index;
        Modular.get<BlocScroll>()
            .add(state.biggest.height >= MediaQuery.of(context).size.height);
        return Column(
          children: [
            widgetList[index],
            SizedBox(height: kToolbarHeight),
          ],
        );
      },
    );
  }
}
