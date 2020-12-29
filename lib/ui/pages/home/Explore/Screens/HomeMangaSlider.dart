import 'package:Oukami/components/ImageShimmer.dart';
import 'package:Oukami/config/Config.dart';
import 'package:Oukami/models/HomeManga.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeMangaSlider extends StatelessWidget {
  HomeMangaSlider({
    this.width,
    this.data,
  });

  final double width;
  final List<HomeManga> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      width: width,
      height: (width * .63),
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: data.map((e) {
          if (data.indexOf(e) == 0) {
            return Container(
              margin: EdgeInsets.only(left: 5.0),
              child: SingleProject(
                width: width,
                image: e.image,
                title: e.title,
                manga_endpoint: e.manga_endpoint,
                chapter: e.chapter.toString(),
                rating: e.rating,
              ),
            );
          } else if (data.indexOf(e) == data.length - 1) {
            return Container(
              margin: EdgeInsets.only(right: 5.0),
              child: SingleProject(
                width: width,
                image: e.image,
                title: e.title,
                manga_endpoint: e.manga_endpoint,
                chapter: e.chapter.toString(),
                rating: e.rating,
              ),
            );
          } else {
            return SingleProject(
              width: width,
              image: e.image,
              title: e.title,
              manga_endpoint: e.manga_endpoint,
              chapter: e.chapter.toString(),
              rating: e.rating,
            );
          }
        }).toList(),
      ),
    );
  }
}

class SingleProject extends StatelessWidget {
  const SingleProject({
    Key key,
    @required this.width,
    this.image,
    this.title,
    this.type,
    this.chapter,
    this.rating,
    // ignore: non_constant_identifier_names
    this.manga_endpoint,
  }) : super(key: key);

  final double width;
  // ignore: non_constant_identifier_names
  final String image, title, chapter, type, manga_endpoint, rating;

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
      child: Container(
        margin: EdgeInsets.only(left: 8.0, right: 8.0),
        width: width * .32,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    boxShadow: [
                      BoxShadow(
                        color: BNBColor,
                        offset: Offset(0.0, 1.5),
                        blurRadius: 8.0,
                      ),
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      width: width * .32,
                      height: width * .44,
                      placeholder: (_, __) => ImageShimmer(
                        width: width * .32,
                        height: width * .44,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 8, bottom: 6),
              child: Text(
                title,
                style: GoogleFonts.heebo(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              chapter,
              style: GoogleFonts.heebo(
                fontSize: 14.5,
                height: 1.1,
                color: BaseColor,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
