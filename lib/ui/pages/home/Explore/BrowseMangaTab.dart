import 'package:Oukami/database/MangaData.dart';

import 'package:Oukami/config/Config.dart';
import 'package:Oukami/models/AllManga.dart';
import 'package:Oukami/models/BestSeries.dart';
import 'package:Oukami/models/HomeManga.dart';
import 'package:Oukami/models/LatestChapterManga.dart';
import 'package:Oukami/models/MangaV1.dart';
import 'package:Oukami/ui/pages/home/Explore/Screens/SubHeader.dart';
import 'package:Oukami/ui/pages/home/Explore/Screens/TopSlider.dart';
import 'package:Oukami/ui/pages/home/Explore/Screens/AllMangaSlider.dart';
import 'package:Oukami/ui/pages/home/Explore/Screens/HomeMangaSlider.dart';
import 'package:Oukami/ui/pages/home/Explore/Screens/LatestChapterSlider.dart';
import 'package:Oukami/ui/pages/home/Explore/Screens/PopularMangaSlider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BrowseMangaTab extends StatefulWidget {
  @override
  _BrowseTabState createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseMangaTab>
    with AutomaticKeepAliveClientMixin {
  var _isLoaded = false;
  List<MangaV1> popularList = [];
  List<BestSeries> bestSeriesList = [];
  List<HomeManga> homeList = [];
  List<LatestChapterManga> latestChapterList = [];
  List<AllManga> allList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    final resData = await MangaData.getHomeData();
    popularList = resData['popularManga'];
    bestSeriesList = resData['bestSeriesManga'];
    homeList = resData['homeManga'];
    latestChapterList = resData['latestChapterManga'];
    allList = resData['allManga'];
    setState(() {
      _isLoaded = true;
    });
  }

  Future<void> onRefresh() async => getData();

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      child: _isLoaded
          ? RefreshIndicator(
              onRefresh: onRefresh,
              child: ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  // TopSlider(),
                  SubHeader(
                    text: 'recommendation',
                    width: width,
                    onPressed: () => Modular.to.pushNamed(
                      '/homeother',
                      arguments: {'title': 'Update Project'},
                    ),
                  ),
                  HomeMangaSlider(width: width, data: homeList),
                  SubHeader(
                    text: 'browse',
                    width: width,
                    onPressed: () => Modular.to.pushNamed(
                      '/homeother',
                      arguments: {'title': 'Update Project'},
                    ),
                  ),
                  AllMangaSlider(width: width, data: allList),
                  SubHeader(
                    text: 'popular',
                    width: width,
                    onPressed: () => Modular.to.pushNamed(
                      '/homeother',
                      arguments: {'title': 'Update Project'},
                    ),
                  ),
                  PopularMangaSlider(width: width, data: popularList),
                  SubHeader(
                    text: 'popular',
                    width: width,
                    onPressed: () => Modular.to.pushNamed(
                      '/homeother',
                      arguments: {'title': 'Update Project'},
                    ),
                  ),
                  LatestChapterSlider(width: width, data: latestChapterList),
                  SizedBox(
                    height: 20,
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
                            style:
                                TextStyle(fontSize: 32.0, color: Colors.white),
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
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(BaseColor),
              ),
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
