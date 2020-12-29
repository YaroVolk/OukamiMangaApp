import 'dart:ui';

import 'package:Oukami/config/Config.dart';
import 'package:Oukami/components/ClipShadowPath.dart';
import 'package:Oukami/ui/pages/home/Explore/BrowseMangaTab.dart';
import 'package:Oukami/ui/pages/home/Other/OtherMangaTab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  var pressed = false;
  TabController _nestedTabController;

  @override
  void initState() {
    super.initState();

    _nestedTabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                shadowColor: Colors.transparent,
                backgroundColor: BGColor,
                toolbarHeight: 10,
                expandedHeight: 205,
                floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: ListView(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 4),
                    children: <Widget>[
                      ClipShadowPath(
                        clipper: CustomShapeClipper(),
                        shadow: Shadow(blurRadius: 20),
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'lib/assets/home/Topbar2.jpg',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
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
                    indicatorWeight: 2,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: <Widget>[
                      Tab(
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 12, bottom: 12, left: 18, right: 18),
                          child: Center(
                            child: Text(
                              "DAILY",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                letterSpacing: 0.27,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 12, bottom: 12, left: 48, right: 48),
                          child: Center(
                            child: Text(
                              "MONTHLY HIGHLIGHTS",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                letterSpacing: 0.27,
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
              height: 2400,
              child: TabBarView(
                controller: _nestedTabController,
                children: <Widget>[
                  BrowseMangaTab(),
                  OtherMangaTab(),
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
