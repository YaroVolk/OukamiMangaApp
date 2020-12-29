import 'dart:ui';

import 'package:Oukami/config/Config.dart';
import 'package:Oukami/database/comic_data.dart';
import 'package:Oukami/models/other_comic.dart';
import 'package:Oukami/ui/pages/explore/ExploreBanner.dart';
import 'package:Oukami/ui/pages/explore/Tabs/ManhwaListTab.dart';
import 'package:Oukami/ui/pages/explore/Tabs/ManhuaListTab.dart';
import 'package:Oukami/ui/pages/explore/Tabs/MangaListTab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ExplorePage extends StatefulWidget {
  String name;
  String appBarTitle;
  ExplorePage({this.name, this.appBarTitle, Key key}) : super(key: key) {
    print(name);
  }

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with TickerProviderStateMixin {
  var pressed = false;
  TabController _nestedTabController;
  List<String> urls = [
    "https://manhua.qpic.cn/operation/0/19_23_51_3fa71e4fd07f0f370af0465faa6ccdb5_1555689063579.jpg/0",
    "https://manhua.qpic.cn/operation/0/19_23_51_898a3baa00cba550d9fe64a372bee24a_1555689101098.jpg/0",
    "https://manhua.qpic.cn/operation/0/19_23_52_6234abed1062e3601cd639fd376760a3_1555689133306.jpg/0",
    "https://manhua.qpic.cn/operation/0/19_23_52_c0343c40a42861d776eb2b265015bef2_1555689169278.jpg/0",
    "https://manhua.qpic.cn/operation/0/19_23_53_8968d75fb1619aa30adfaf271a271642_1555689199834.jpg/0"
  ];

  @override
  void initState() {
    super.initState();
    _nestedTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  ScrollController _controller = ScrollController();
  bool _firstLoaded = false, _isLoading = false;
  int page = 1;
  List<OtherComic> results = [];
  final controller = ScrollController();

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
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                shadowColor: Colors.transparent,
                backgroundColor: BGColor,
                toolbarHeight: 10,
                expandedHeight: 215.0,
                floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: ListView(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 4),
                    children: <Widget>[
                      ExploreBanner(urls),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _nestedTabController,
                    mouseCursor: MouseCursor.defer,
                    indicatorColor: BaseColor,
                    labelColor: BaseColor,
                    unselectedLabelColor: BNBColor,
                    isScrollable: false,
                    indicatorWeight: 3,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: <Widget>[
                      Tab(
                        child: Container(
                          child: Center(
                            child: Text(
                              "MANGAR",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Center(
                            child: Text(
                              "MANHUA",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Center(
                            child: Text(
                              "MANHWA",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: Expanded(
            child: Container(
              height: 5400,
              child: TabBarView(
                controller: _nestedTabController,
                children: <Widget>[
                  MangaListTab(),
                  ManhuaListTab(),
                  ManhwaListTab(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: BGColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
