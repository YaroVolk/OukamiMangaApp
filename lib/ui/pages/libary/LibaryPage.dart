import 'package:Oukami/config/Config.dart';
import 'package:Oukami/ui/pages/libary/DownloadPage.dart';
import 'package:Oukami/ui/pages/libary/FavoriteTabPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LibaryPage extends StatefulWidget {
  @override
  _LibaryPageState createState() => _LibaryPageState();
}

class _LibaryPageState extends State<LibaryPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 55,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.transparent,
          labelColor: BaseColor,
          unselectedLabelColor: BNBColor,
          indicatorSize: TabBarIndicatorSize.tab,
          isScrollable: false,
          tabs: <Widget>[
            Tab(
              child: Text(
                "Downloads",
                style: GoogleFonts.heebo(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Tab(
              child: Text(
                "Favourites",
                style: GoogleFonts.heebo(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Container(
            child: DownloadPage(),
          ),
          Container(
            child: FavoriteTabPage(),
          ),
        ],
      ),
    );
  }
}
