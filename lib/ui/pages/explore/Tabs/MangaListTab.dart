import 'package:Oukami/database/MangaData.dart';
import 'package:Oukami/components/MangaType.dart';
import 'package:Oukami/components/ImageShimmer.dart';
import 'package:Oukami/config/Config.dart';
import 'package:Oukami/models/MangaList.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class MangaListTab extends StatefulWidget {
  final String appBarTitle;

  MangaListTab({this.appBarTitle});

  @override
  _SubPageState createState() => _SubPageState();
}

class _SubPageState extends State<MangaListTab> {
  ScrollController _controller = ScrollController();
  bool _firstLoaded = false, _isLoading = false;
  int page = 1;
  List<MangaList> results = [];

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
              ? await MangaData.getMangaChapter(page: page)
              : await MangaData.getMangaProject(page: page),
        );
        setState(() {
          _isLoading = false;
        });
      });
    });
  }

  void getChapterTerbaru() async {
    results = await MangaData.getMangaChapter(page: page);
    setState(() {
      _firstLoaded = true;
    });
  }

  void getProject() async {
    results = await MangaData.getMangaProject(page: page);
    setState(() {
      _firstLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Container(
      child: _firstLoaded
          ? ListView(
              shrinkWrap: true,
              children: [
                SizedBox(height: 4.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Wrap(
                    spacing: 8.0,
                    children: results
                        .map(
                          (e) => RecentDetail(
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: GradientColor, border: Border.symmetric()),
                      child: RaisedButton(
                        splashColor: Colors.teal[200],
                        color: BaseColor,
                        child: Text(
                          "MORE",
                          style: TextStyle(fontSize: 32.0, color: Colors.white),
                        ),
                        onPressed: () => Modular.to.pushNamed(
                          '/homeother',
                          arguments: {'title': 'Update Project'},
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                _isLoading
                    ? Container(
                        margin: EdgeInsets.only(top: 8.0, bottom: 20.0),
                        child: CircularProgressIndicator(),
                      )
                    : Container(),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class RecentDetail extends StatelessWidget {
  const RecentDetail({
    Key key,
    @required this.width,
    this.image,
    this.title,
    this.type,
    this.chapter,
    // ignore: non_constant_identifier_names
    this.manga_endpoint,
    this.rating,
  }) : super(key: key);

  final double width;
  // ignore: non_constant_identifier_names
  final String image, type, title, chapter, manga_endpoint, rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: () => Modular.to.pushNamed('/detailmanga', arguments: {
              'image': image,
              'title': title,
              'manga_endpoint': manga_endpoint,
            }),
            child: Container(
              width: (width * .4819) - 82.0,
              alignment: Alignment.center,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            boxShadow: [
                              BoxShadow(
                                color: BNBColor,
                                offset: Offset(0.0, 1.5),
                                blurRadius: 8.0,
                              ),
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: CachedNetworkImage(
                              imageUrl: image,
                              fit: BoxFit.cover,
                              width: (width * .464) - 12.0,
                              height: width * .50,
                              useOldImageOnUrlChange: true,
                              placeholder: (_, __) => ImageShimmer(
                                width: (width * .464) - 12.0,
                                height: width * .50,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8.0,
                          left: 8.0,
                          child: MangaType(text: type),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        title,
                        style: GoogleFonts.heebo(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          chapter,
                          style: GoogleFonts.heebo(
                            fontSize: 13,
                            height: 1.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        rating != null
                            ? Container(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 18,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      rating,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context)
                                            .textSelectionHandleColor
                                            .withOpacity(.6),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 12.0),
        ],
      ),
    );
  }
}
