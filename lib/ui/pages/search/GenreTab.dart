import 'package:Oukami/config/Config.dart';
import 'package:Oukami/ui/pages/search/RecoList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:Oukami/ui/pages/search/ListData.dart';
import 'package:Oukami/ui/pages/search/CardScroll.dart';

class GenreTab extends StatefulWidget {
  dynamic categoryList;

  GenreTab({@required this.categoryList});

  @override
  _GenreTabState createState() => _GenreTabState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _GenreTabState extends State<GenreTab>
    with AutomaticKeepAliveClientMixin {
  var currentPage = images.length - 1.0;

  @override
  bool get wantKeepAlive => true;

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

    return Container(
      color: BGColor,
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            height: 280,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, 10.0),
                    blurRadius: 10.0)
              ],
              image: DecorationImage(
                  image: AssetImage('lib/assets/backgrounds/searchbar3.jpg'),
                  fit: BoxFit.cover),
            ),
            child: Container(
              decoration: BoxDecoration(
                  gradient:
                      LinearGradient(begin: Alignment.bottomRight, colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.2),
              ])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Search your Manga",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 15),
                          hintText: "Search Manga ..."),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 30,
              ),
              Text(
                "Browse",
                style: TextStyle(
                    color: BaseColor,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Stack(
            // PLESE ADD TEXT ICONS
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
          Expanded(
            child: RecommendationTab(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Shonan",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: BaseColor,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      makeItem(
                          image: 'lib/assets/search/images/aot.jpg',
                          title: 'One Piece'),
                      makeItem(
                          image: 'lib/assets/search/images/boruto.jpg',
                          title: 'Boruto'),
                      makeItem(
                          image: 'lib/assets/search/images/hunterxhunter.png',
                          title: 'Hunter x Hunter'),
                      makeItem(
                          image: 'lib/assets/search/images/noragami.jfif',
                          title: 'Noragami'),
                      makeItem(
                          image: 'lib/assets/search/images/myheroacademia.jpg',
                          title: 'My Hero Academia'),
                      makeItem(
                          image: 'lib/assets/search/images/fma.png',
                          title: 'Full Metal Allchemist'),
                      makeItem(
                          image: 'lib/assets/search/images/bc.jpg',
                          title: 'Black Clover'),
                      makeItem(
                          image: 'lib/assets/search/images/Jojo.jpg',
                          title: 'Jojos Bizarre Adventure')
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Comedy",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: BaseColor,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      makeItem(
                          image: 'lib/assets/search/images/gintama.png',
                          title: 'Gintama'),
                      makeItem(
                          image: 'lib/assets/search/images/konosuba.png',
                          title: 'KonoSuba'),
                      makeItem(
                          image: 'lib/assets/search/images/saiki.jpg',
                          title: 'The Disastrous Life of Saiki K.'),
                      makeItem(
                          image: 'lib/assets/search/images/toradora.png',
                          title: 'Toradora'),
                      makeItem(
                          image: 'lib/assets/search/images/nisekoi.jpg',
                          title: 'Nisekoi'),
                      makeItem(
                          image: 'lib/assets/search/images/opm.jpg',
                          title: 'One Punch Man'),
                      makeItem(
                          image: 'lib/assets/search/images/nichijou.png',
                          title: 'Nichijou'),
                      makeItem(
                          image: 'lib/assets/search/images/klk.jpg',
                          title: 'Kill la Kill'),
                      makeItem(
                          image: 'lib/assets/search/images/mb.png',
                          title: 'Mob Psycho 100'),
                      makeItem(
                          image: 'lib/assets/search/images/gto.jpg',
                          title: 'Great Teacher Onizuka'),
                      makeItem(
                          image: 'lib/assets/search/images/sb.gif',
                          title: 'Shirobako'),
                      makeItem(
                          image: 'lib/assets/search/images/nhk.jpg',
                          title: 'Welcome to NHK')
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Action",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: BaseColor,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      makeItem(
                          image: 'lib/assets/search/images/aot.jpg',
                          title: 'Attack on Titan'),
                      makeItem(
                          image: 'lib/assets/search/images/sao.jpg',
                          title: 'Sword Art Online'),
                      makeItem(
                          image: 'lib/assets/search/images/pp.jpg',
                          title: 'Psycho Pass'),
                      makeItem(
                          image: 'lib/assets/search/images/bl.png',
                          title: 'Black Lagoon'),
                      makeItem(
                          image: 'lib/assets/search/images/vs.jpg',
                          title: 'Vinland Saga'),
                      makeItem(
                          image: 'lib/assets/search/images/gl.jpg',
                          title: 'Gurren Lagann'),
                      makeItem(
                          image: 'lib/assets/search/images/fsn.png',
                          title: 'Fate Stay Night'),
                      makeItem(
                          image: 'lib/assets/search/images/sg.jpg',
                          title: 'Steins Gate')
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Comedy",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: BaseColor,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      makeItem(
                          image: 'lib/assets/search/images/mn.png',
                          title: 'Mirai Nikki'),
                      makeItem(
                          image: 'lib/assets/search/images/an.jpg',
                          title: 'Another'),
                      makeItem(
                          image: 'lib/assets/search/images/vb.jpg',
                          title: 'Vagabond'),
                      makeItem(
                          image: 'lib/assets/search/images/mia.gif',
                          title: 'Made in Abyss'),
                      makeItem(
                          image: 'lib/assets/search/images/dn.gif',
                          title: 'Death Note')
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Sports",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: BaseColor,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      makeItem(
                          image: 'lib/assets/search/images/knb.png',
                          title: 'Kuroko no Basket'),
                      makeItem(
                          image: 'lib/assets/search/images/haikyuu.png',
                          title: 'Haikyuu'),
                      makeItem(
                          image: 'lib/assets/search/images/sd.jpg',
                          title: 'Mob Psycho 100'),
                      makeItem(
                          image: 'lib/assets/search/images/hni.jpg',
                          title: 'Hajime no Ippo'),
                      makeItem(
                          image: 'lib/assets/search/images/tb.jpg',
                          title: 'The Breaker')
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Action",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: BaseColor,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      makeItem(
                          image: 'lib/assets/search/images/ngn.png',
                          title: 'No Game No Life'),
                      makeItem(
                          image: 'lib/assets/search/images/sds.png',
                          title: 'The Seven Deadly Sins'),
                      makeItem(
                          image: 'lib/assets/search/images/cb.png',
                          title: 'Cowboy Bebop'),
                      makeItem(
                          image: 'lib/assets/search/images/lg.gif',
                          title: 'Ginga Eiyuu Densetsu')
                    ],
                  ),
                ),
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
                          style: TextStyle(fontSize: 32.0, color: Colors.white),
                        ),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget makeItem({image, title}) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: Container(
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.2),
              ])),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}

class Mclipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 100.0);

    var controlpoint = Offset(35.0, size.height);
    var endpoint = Offset(size.width / 2, size.height);

    path.quadraticBezierTo(
        controlpoint.dx, controlpoint.dy, endpoint.dx, endpoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
