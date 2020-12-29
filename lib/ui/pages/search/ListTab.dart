import 'package:Oukami/config/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Oukami/ui/pages/search/ListData.dart';

class ListTab extends StatefulWidget {
  dynamic categoryList;

  ListTab({@required this.categoryList});

  @override
  _ListTabState createState() => _ListTabState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _ListTabState extends State<ListTab> with AutomaticKeepAliveClientMixin {
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
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.categoryList.length,
            itemBuilder: (context, index) {
              return Container(
                height: 50,
                margin: EdgeInsets.only(top: 5),
                child: FlatButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => GenreScreen(
                    //             genre: widget.categoryList[index],
                    //           )),
                    // );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.categoryList[index]["tagName"],
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.navigate_next,
                        color: Colors.black38,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
