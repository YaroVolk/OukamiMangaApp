import 'package:Oukami/database/MangaData.dart';

import 'package:Oukami/bloc/BlocWidget.dart';
import 'package:Oukami/models/DetailManga.dart';
import 'package:Oukami/ui/detail/DetailBar/BackgroundBar.dart';
import 'package:Oukami/ui/detail/DetailBar/CustomAppBar.dart';
import 'package:Oukami/ui/detail/DetailBody/BodyContent.dart';
import 'package:Oukami/ui/detail/DetailBody/FloatingIcon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DetailPage extends StatefulWidget {
  // ignore: non_constant_identifier_names
  DetailPage({this.image, this.title, this.manga_endpoint});

  // ignore: non_constant_identifier_names
  final String image, title, manga_endpoint;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var top = 0.0;
  var blur = 0.0;
  bool isLoaded = false;
  DetailManga detail = DetailManga();
  ChapterListDetail idFirstChapter;

  @override
  void initState() {
    super.initState();
    getData();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  void getData() async {
    detail = await MangaData.getDetailManga(id: widget.manga_endpoint);
    idFirstChapter = detail.chapterList.last;
    if (this.mounted)
      setState(() {
        isLoaded = true;
      });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    // ignore: close_sinks
    final sliverBloc = Modular.get<BlocSliver>();
    // ignore: close_sinks
    final blurBloc = Modular.get<BlocBlur>();

    return Scaffold(
      body: DefaultTabController(
        length: 1,
        child: Container(
          width: width,
          height: height,
          child: Stack(
            children: [
              CustomScrollView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                slivers: [
                  SliverAppBar(
                    shadowColor: Colors.transparent,
                    pinned: true,
                    floating: false,
                    expandedHeight: 650,
                    backgroundColor: Theme.of(context).textSelectionColor,
                    flexibleSpace: LayoutBuilder(
                      builder: (context, constraints) {
                        top = constraints.biggest.height;
                        blur = ((width / constraints.biggest.height) - 1) * 4;
                        blurBloc.add(blur);
                        sliverBloc.add(
                          top ==
                                  MediaQuery.of(context).padding.top +
                                      kToolbarHeight
                              ? true
                              : false,
                        );
                        return FlexibleSpaceBar(
                          title: Container(),
                          background: BackgroundBar(
                            image: widget.image,
                            title: widget.title,
                            isLoaded: isLoaded,
                            width: width,
                            detail: detail,
                          ),
                        );
                      },
                    ),
                    leading: Container(),
                    actions: [Container()],
                  ),
                  BodyContent(
                    width: width,
                    setState: this.setState,
                    isLoaded: isLoaded,
                    detail: detail,
                    mangaId: widget.manga_endpoint,
                    title: widget.title,
                  ),
                ],
              ),
              CustomAppBar(
                sliverBloc: sliverBloc,
                width: width,
                image: widget.image,
                title: widget.title,
                isLoaded: isLoaded,
                detail: detail,
              ),
              isLoaded
                  ? FloatingMenu(
                      width: width,
                      mangaId: widget.manga_endpoint,
                      chapter: detail.chapterList.last,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
