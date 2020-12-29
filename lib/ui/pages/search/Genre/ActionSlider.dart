import 'package:Oukami/config/Config.dart';
import 'package:Oukami/models/Genre/ActionGenre.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class ActionSlider extends StatelessWidget {
  ActionSlider({
    this.width,
    this.data,
  });

  final double width;
  final List<ActionGenre> data;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 0.445,
      child: Padding(
        padding: EdgeInsets.only(left: 20, top: 10),
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: data.map((e) {
            if (data.indexOf(e) == 0) {
              return SingleProject(
                width: width,
                image: e.image,
                title: e.title,
                chapter: e.chapter.toString(),
                manga_endpoint: e.manga_endpoint,
              );
            } else if (data.indexOf(e) == data.length - 1) {
              return SingleProject(
                width: width,
                image: e.image,
                title: e.title,
                chapter: e.chapter.toString(),
                manga_endpoint: e.manga_endpoint,
              );
            } else {
              return SingleProject(
                width: width,
                image: e.image,
                title: e.title,
                chapter: e.chapter.toString(),
                manga_endpoint: e.manga_endpoint,
              );
            }
          }).toList(),
        ),
      ),
    );
  }
}

class SingleProject extends StatelessWidget {
  const SingleProject({
    Key key,
    @required this.width,
    this.chapter,
    this.image,
    this.title,
    this.type,
    // ignore: non_constant_identifier_names
    this.manga_endpoint,
  }) : super(key: key);

  final double width;
  // ignore: non_constant_identifier_names
  final String image, title, chapter, type, manga_endpoint;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Modular.to.pushNamed(
        '/detailmanga',
        arguments: {
          'image': image,
          'title': title,
          'manga_endpoint': manga_endpoint,
        },
      ),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(right: 15),
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover)),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  colors: [
                    Colors.black.withOpacity(.8),
                    Colors.black.withOpacity(.2),
                  ],
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  title,
                  style: GoogleFonts.heebo(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: BGColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
