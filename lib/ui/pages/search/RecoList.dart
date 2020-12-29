import 'package:Oukami/database/MangaData.dart';
import 'package:Oukami/config/Config.dart';
import 'package:Oukami/models/BestSeries.dart';
import 'package:Oukami/models/Genre/ActionGenre.dart';
import 'package:Oukami/models/Genre/AdventureGenre.dart';
import 'package:Oukami/models/Genre/ComedyGenre.dart';
import 'package:Oukami/models/Genre/DramaGenre.dart';
import 'package:Oukami/models/Genre/FantasyGenre.dart';
import 'package:Oukami/models/Genre/HaremGenre.dart';
import 'package:Oukami/models/Genre/HorrorGenre.dart';
import 'package:Oukami/models/Genre/MartialartsGenre.dart';
import 'package:Oukami/models/Genre/ShoujoGenre.dart';
import 'package:Oukami/models/Genre/ShounenGenre.dart';
import 'package:Oukami/models/Genre/ThrillerGenre.dart';
import 'package:Oukami/ui/pages/home/Explore/Screens/SubHeader.dart';
import 'package:Oukami/ui/pages/search/CardScroll.dart';
import 'package:Oukami/ui/pages/search/Genre/ActionSlider.dart';
import 'package:Oukami/ui/pages/search/Genre/AdventureSlider.dart';
import 'package:Oukami/ui/pages/search/Genre/ComedySlider.dart';
import 'package:Oukami/ui/pages/search/Genre/DramaSlider.dart';
import 'package:Oukami/ui/pages/search/Genre/FantasySlider.dart';
import 'package:Oukami/ui/pages/search/Genre/HaremSlider.dart';
import 'package:Oukami/ui/pages/search/Genre/HorrorSlider.dart';
import 'package:Oukami/ui/pages/search/Genre/MartialartsSlider.dart';
import 'package:Oukami/ui/pages/search/Genre/ShoujoSlider.dart';
import 'package:Oukami/ui/pages/search/Genre/ShounenSlider.dart';
import 'package:Oukami/ui/pages/search/Genre/ThrillerSlider.dart';

import 'package:Oukami/ui/pages/search/ListData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class RecommendationTab extends StatefulWidget {
  @override
  _BrowseTabState createState() => _BrowseTabState();
}

class _BrowseTabState extends State<RecommendationTab>
    with AutomaticKeepAliveClientMixin {
  var currentPage = images.length - 1.0;
  var _isLoaded = false;
  List<BestSeries> bestSeriesList = [];
  List<ActionGenre> actionList = [];
  List<AdventureGenre> adventureList = [];
  List<ComedyGenre> comedyList = [];
  List<DramaGenre> dramaList = [];
  List<FantasyGenre> fantasyList = [];
  List<HaremGenre> haremList = [];
  List<HorrorGenre> horrorList = [];
  List<MartialartsGenre> martialartsList = [];
  List<ShoujoGenre> shoujoList = [];
  List<ShounenGenre> shounenList = [];
  List<ThrillerGenre> thrillerList = [];

  @override
  void initState() {
    super.initState();
    getData1();
  }

  void getData1() async {
    final resData = await MangaData.getHomeData();
    bestSeriesList = resData['bestSeriesManga'];
    actionList = resData['actionManga'];
    adventureList = resData['adventureManga'];
    comedyList = resData['comedyManga'];
    dramaList = resData['dramaManga'];
    fantasyList = resData['fantasyManga'];
    haremList = resData['haremManga'];
    horrorList = resData['horrorManga'];
    martialartsList = resData['martialartsManga'];
    shoujoList = resData['shoujoManga'];
    shounenList = resData['shounenManga'];
    thrillerList = resData['thrillerManga'];

    setState(() {
      _isLoaded = true;
    });
  }

  Future<void> onRefresh1() async => getData1();

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: images.length - 2);
    controller.addListener(
      () {
        setState(
          () {
            currentPage = controller.page;
          },
        );
      },
    );
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: 870,
      child: _isLoaded
          ? RefreshIndicator(
              onRefresh: onRefresh1,
              child: ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "BROWSE",
                        style: GoogleFonts.heebo(
                            fontSize: 26,
                            color: BaseColor,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  Stack(
                    children: <Widget>[
                      CardScroll(currentPage),
                      Positioned.fill(
                        child: PageView.builder(
                          itemCount: images.length,
                          controller: controller,
                          reverse: true,
                          itemBuilder: (context, index) {
                            return Container();
                          },
                        ),
                      )
                    ],
                  ),
                  SubHeader(
                    text: 'action',
                    width: width,
                    onPressed: () => Modular.to.pushNamed(
                      '/homeother',
                      arguments: {'title': 'Update Project'},
                    ),
                  ),
                  ActionSlider(width: width, data: actionList),
                  SizedBox(
                    height: 20,
                  ),
                  SubHeader(
                    text: 'adventure',
                    width: width,
                    onPressed: () => Modular.to.pushNamed(
                      '/homeother',
                      arguments: {'title': 'Update Project'},
                    ),
                  ),
                  AdventureSlider(width: width, data: adventureList),
                  SizedBox(
                    height: 20,
                  ),
                  SubHeader(
                    text: 'comedy',
                    width: width,
                    onPressed: () => Modular.to.pushNamed(
                      '/homeother',
                      arguments: {'title': 'Update Project'},
                    ),
                  ),
                  ComedySlider(width: width, data: comedyList),
                  SizedBox(
                    height: 20,
                  ),
                  SubHeader(
                    text: 'drama',
                    width: width,
                    onPressed: () => Modular.to.pushNamed(
                      '/homeother',
                      arguments: {'title': 'Update Project'},
                    ),
                  ),
                  DramaSlider(width: width, data: dramaList),
                  SizedBox(
                    height: 20,
                  ),
                  SubHeader(
                    text: 'fantasy',
                    width: width,
                    onPressed: () => Modular.to.pushNamed(
                      '/homeother',
                      arguments: {'title': 'Update Project'},
                    ),
                  ),
                  FantasySlider(width: width, data: fantasyList),
                  SizedBox(
                    height: 20,
                  ),
                  SubHeader(
                    text: 'harem',
                    width: width,
                    onPressed: () => Modular.to.pushNamed(
                      '/homeother',
                      arguments: {'title': 'Update Project'},
                    ),
                  ),
                  HaremSlider(width: width, data: haremList),
                  SizedBox(
                    height: 20,
                  ),
                  SubHeader(
                    text: 'horror',
                    width: width,
                    onPressed: () => Modular.to.pushNamed(
                      '/homeother',
                      arguments: {'title': 'Update Project'},
                    ),
                  ),
                  HorrorSlider(width: width, data: horrorList),
                  SizedBox(
                    height: 20,
                  ),
                  SubHeader(
                    text: 'martial arts',
                    width: width,
                    onPressed: () => Modular.to.pushNamed(
                      '/homeother',
                      arguments: {'title': 'Update Project'},
                    ),
                  ),
                  MartialartsSlider(width: width, data: martialartsList),
                  SizedBox(
                    height: 20,
                  ),
                  SubHeader(
                    text: 'shoujo',
                    width: width,
                    onPressed: () => Modular.to.pushNamed(
                      '/homeother',
                      arguments: {'title': 'Update Project'},
                    ),
                  ),
                  ShoujoSlider(width: width, data: shoujoList),
                  SizedBox(
                    height: 20,
                  ),
                  SubHeader(
                    text: 'shounen',
                    width: width,
                    onPressed: () => Modular.to.pushNamed(
                      '/homeother',
                      arguments: {'title': 'Update Project'},
                    ),
                  ),
                  ShounenSlider(width: width, data: shounenList),
                  SizedBox(
                    height: 20,
                  ),
                  SubHeader(
                    text: 'thriller',
                    width: width,
                    onPressed: () => Modular.to.pushNamed(
                      '/homeother',
                      arguments: {'title': 'Update Project'},
                    ),
                  ),
                  ThrillerSlider(width: width, data: thrillerList),
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
