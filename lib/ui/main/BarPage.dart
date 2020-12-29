import 'package:Oukami/config/Config.dart';
import 'package:Oukami/ui/pages/explore/ExplorePage.dart';
import 'package:Oukami/ui/pages/home/HomePage.dart';
import 'package:Oukami/ui/pages/libary/LibaryPage.dart';
import 'package:Oukami/ui/pages/search/SearchPage.dart';
import 'package:Oukami/ui/pages/settings/SettingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

// ignore: must_be_immutable
class BarPage extends StatefulWidget {
  @override
  _BarPageState createState() => _BarPageState();
}

class _BarPageState extends State<BarPage> {
  Color themeColor = BaseColor;
  final appBarTitles = ['Home', 'Search', 'Upload', 'Libary', 'Setting'];

  final tabTextStyleSelected = TextStyle(color: BaseColor);
  final tabTextStyleNormal = TextStyle(color: Color(0xff969696));
  int _tabIndex = 0;

  var tabImages;
  var _body;
  var pages;

  Image getTabImage(path) {
    return Image.asset(path, width: 28, height: 28);
  }

  @override
  void initState() {
    super.initState();

    pages = <Widget>[
      HomePage(),
      SearchPage(),
      ExplorePage(),
      LibaryPage(),
      SettingPage(),
    ];

    if (tabImages == null) {
      tabImages = [
        [
          getTabImage('lib/assets/bar/normal.png'),
          getTabImage('lib/assets/bar/normal.png')
        ],
      ];
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onTapAct(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  Image getBigTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return Image.asset('lib/assets/bar/center_active2.png',
          width: 80.0, height: 80.0);
    }
    return Image.asset('lib/assets/bar/center_active3.png',
        width: 90.0, height: 90.0);
  }

  Text getTabTitle(int curIndex) {
    return Text(appBarTitles[curIndex], style: getTabTextStyle(curIndex));
  }

  TextStyle getTabTextStyle(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabTextStyleSelected;
    }
    return tabTextStyleNormal;
  }

  @override
  Widget build(BuildContext context) {
    _body = IndexedStack(
      children: pages,
      index: _tabIndex,
    );

    return Scaffold(
      body: _body,
      floatingActionButton: Container(
        width: _tabIndex == 2 ? 75 : 50,
        height: _tabIndex == 2 ? 75 : 50,
        margin: EdgeInsets.only(top: _tabIndex == 2 ? 25 : 50),
        child:
            IconButton(icon: getBigTabIcon(2), onPressed: () => {onTapAct(2)}),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: BNBColor,
        selectedItemColor: BaseColor,
        elevation: 60,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white.withOpacity(0.1),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Feather.home), title: getTabTitle(0)),
          BottomNavigationBarItem(
              icon: Icon(Feather.search), title: getTabTitle(1)),
          BottomNavigationBarItem(icon: getTabIcon(0), title: Text('')),
          BottomNavigationBarItem(
              icon: Icon(Feather.book_open), title: getTabTitle(3)),
          BottomNavigationBarItem(
              icon: Icon(Feather.settings), title: getTabTitle(4)),
        ],
        currentIndex: _tabIndex,
        onTap: (index) {
          onTapAct(index);
        },
      ),
    );
  }
}
