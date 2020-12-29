import 'dart:math';

import 'package:Oukami/config/Config.dart';
import 'package:flutter/material.dart';

class  TopSlider extends StatefulWidget {
  @override
  _TopSliderState createState() => _TopSliderState();
}

class _TopSliderState extends State<TopSlider> {
  List compilation = [
    {
      "title": "Browse Manga",
      "subtitle": "Explore the newest Manga updates from Japan."
    },
    {
      "title": "Browse Manhua",
      "subtitle": "Best chinese Series."
    },
    {
      "title": "Browse Manhwa",
      "subtitle": "Koreas popilar Comics and Webtooms."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(left: 10, bottom: 40),
      children: <Widget>[
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: compilation.length,
            itemBuilder: (BuildContext context, int index) {
              Map item = compilation[index];
              Compile i = Compile.fromJson(item);
              MaterialColor color = Colors.primaries[Random().nextInt(16)];

              return Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  height: 200,
                  width: 320,
                  decoration: BoxDecoration(
                    color: color,
                    boxShadow: [
                      BoxShadow(
                        color: BaseColorOpacity,
                        offset: Offset(0.0, 1.5),
                        blurRadius: 5.0,
                      ),
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            i.title,
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            i.subtitle,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class Compile {
  String title;
  String subtitle;

  Compile({this.title, this.subtitle});

  Compile.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    return data;
  }
}
