import 'package:Oukami/components/SearchAppBar.dart';
import 'package:Oukami/database/MangaData.dart';
import 'package:Oukami/config/Config.dart';
import 'package:Oukami/models/SearchManga.dart';
import 'package:Oukami/ui/sub/FavoriteTabPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchTab> {
  final ControllerAppBar appBarController = ControllerAppBar();
  ScrollController _controller = ScrollController();
  bool _isLoading = false, _isGettingData = true, _firstLoaded = false;
  TextEditingController _textController = TextEditingController();
  List<SearchManga> results = [];
  String currentSearchKeyword = '';

  @override
  void initState() {
    listenScroll();
    super.initState();
    Future.delayed(Duration.zero, hideKeyboard);
  }

  void hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void listenScroll() {
    _controller.addListener(() {
      if (_controller.position.atEdge && _controller.position.pixels != 0) {
        loadMore();
      }
    });
  }

  void loadMore() {
    setState(() {
      _isLoading = true;
      Future.delayed(Duration.zero, () async {
        results.addAll(await MangaData.getSearch(query: currentSearchKeyword));
        if (this.mounted)
          setState(() {
            _isLoading = false;
          });
      });
    });
  }

  void getData() async {
    results = await MangaData.getSearch(query: currentSearchKeyword);
    if (this.mounted)
      setState(() {
        currentSearchKeyword = currentSearchKeyword;
        _isGettingData = false;
        _firstLoaded = true;
      });
  }

  void getDataAgain(String keyword) async {
    if (this.mounted) {
      setState(() {
        _firstLoaded = true;
        _isGettingData = true;
        currentSearchKeyword = keyword;
        Future.delayed(Duration.zero, () async {
          results = await MangaData.getSearch(query: keyword);
          setState(() {
            _isGettingData = false;
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: GradientAppBar(
        leading: InkWell(
          child: Icon(
            Feather.x,
            color: Colors.white,
          ),
          onTap: () {
            Modular.to.pop();
          },
        ),
        title: Container(
          child: TextField(
            controller: _textController,
            autofocus: true,
            onSubmitted: getDataAgain,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              hintText: 'Search...',
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: BGColor.withAlpha(100),
              ),
              suffixIcon: Icon(
                Icons.search,
                color: BGColor,
              ),
            ),
          ),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [BaseColor, GradientColor],
        ),
      ),
      body: _firstLoaded == false
          ? Center(
              child: Text(
                "Empty page...",
                style: GoogleFonts.heebo(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )
          : _isGettingData
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : results.length != 0
                  ? SingleChildScrollView(
                      controller: _controller,
                      child: Column(
                        children: [
                          SizedBox(height: 12.0),
                          Container(
                            width: width,
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Wrap(
                              spacing: 8.0,
                              alignment: WrapAlignment.start,
                              children: results
                                  .map(
                                    (e) => ListItemGrid(
                                      width: width,
                                      image: e.image,
                                      title: e.title,
                                      manga_endpoint: e.manga_endpoint,
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
                                  margin:
                                      EdgeInsets.only(top: 5.0, bottom: 20.0),
                                  child: CircularProgressIndicator(),
                                )
                              : Container(),
                        ],
                      ),
                    )
                  : Center(
                      child: Text('Comic Not Found'),
                    ),
    );
  }
}
