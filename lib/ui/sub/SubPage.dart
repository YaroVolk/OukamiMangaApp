import 'package:Oukami/config/Config.dart';
import 'package:Oukami/database/ComicData.dart';
import 'package:Oukami/models/OtherComic.dart';
import 'package:Oukami/ui/sub/SubBody.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class SubPage extends StatefulWidget {
  final String appBarTitle;

  SubPage({this.appBarTitle});

  @override
  _SubPageState createState() => _SubPageState();
}

class _SubPageState extends State<SubPage> {
  ScrollController _controller = ScrollController();
  bool _firstLoaded = false, _isLoading = false;
  int page = 1;
  List<OtherComic> results = [];
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    listenScroll();
    widget.appBarTitle == 'Chapter Terbaru'
        ? getChapterTerbaru()
        : getProject();
  }

  void listenScroll() {
    _controller.addListener(() {
      if (_controller.position.atEdge && _controller.position.pixels != 0) {
        onBottomReached();
      }
    });
  }

  void onBottomReached() {
    setState(() {
      _isLoading = true;
      page++;
      Future.delayed(Duration(seconds: 0), () async {
        results.addAll(
          widget.appBarTitle == 'Chapter Terbaru'
              ? await ComicData.getChapterTerbaru(page: page)
              : await ComicData.getProjectTerbaru(page: page),
        );
        setState(() {
          _isLoading = false;
        });
      });
    });
  }

  void getChapterTerbaru() async {
    results = await ComicData.getChapterTerbaru(page: page);
    setState(() {
      _firstLoaded = true;
    });
  }

  void getProject() async {
    results = await ComicData.getProjectTerbaru(page: page);
    setState(() {
      _firstLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: GradientAppBar(
        title: Text(
          "Browse",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [BaseColor, GradientColor],
        ),
      ),
      body: _firstLoaded
          ? SingleChildScrollView(
              controller: _controller,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 4.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Wrap(
                      spacing: 8.0,
                      children: results
                          .map(
                            (e) => SubBody(
                              width: width,
                              image: e.image,
                              title: e.title,
                              mangaId: e.linkId,
                              type: e.type,
                              chapter: e.chapter,
                              rating: e.rating ?? null,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  _isLoading
                      ? Container(
                          margin: EdgeInsets.only(top: 8.0, bottom: 20.0),
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(BaseColor),
                          ),
                        )
                      : Container(),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
