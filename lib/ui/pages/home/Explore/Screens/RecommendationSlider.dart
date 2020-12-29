import 'package:Oukami/components/MangaType.dart';
import 'package:Oukami/components/ImageShimmer.dart';
import 'package:Oukami/config/Config.dart';
import 'package:Oukami/models/RecommendationManga.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class RecommendationSlider extends StatelessWidget {
  const RecommendationSlider({
    Key key,
    @required this.width,
    this.data,
  }) : super(key: key);

  final double width;
  final List<RecommendationManga> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      width: width,
      height: (width * .68),
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: data.map((e) {
          if (data.indexOf(e) == 0) {
            return Container(
              margin: EdgeInsets.only(left: 5.0),
              child: SingleMangaSlider(
                width: width,
                image: e.image,
                title: e.title,
                type: e.type,
                manga_endpoint: e.manga_endpoint,
                rating: e.rating,
              ),
            );
          } else if (data.indexOf(e) == data.length - 1) {
            return Container(
              margin: EdgeInsets.only(right: 5.0),
              child: SingleMangaSlider(
                width: width,
                image: e.image,
                title: e.title,
                type: e.type,
                manga_endpoint: e.manga_endpoint,
                rating: e.rating,
              ),
            );
          } else {
            return SingleMangaSlider(
              width: width,
              image: e.image,
              title: e.title,
              type: e.type,
              manga_endpoint: e.manga_endpoint,
              rating: e.rating,
            );
          }
        }).toList(),
      ),
    );
  }
}

class SingleMangaSlider extends StatelessWidget {
  const SingleMangaSlider({
    Key key,
    @required this.width,
    // ignore: non_constant_identifier_names
    this.manga_endpoint,
    this.image,
    this.title,
    this.rating,
    this.type,
  }) : super(key: key);

  final double width;
  // ignore: non_constant_identifier_names
  final String image, title, manga_endpoint, type, rating;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Modular.to.pushNamed('/detailmanga', arguments: {
        'image': image,
        'title': title,
        'manga_endpoint': manga_endpoint,
      }),
      child: Container(
        margin: EdgeInsets.only(left: 8.0, right: 8.0),
        width: width * .4,
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
                      width: width * .4,
                      height: width * .55,
                      placeholder: (_, __) => ImageShimmer(
                        width: width * .4,
                        height: width * .55,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8.0,
                  left: 8.0,
                  child: MangaType(text: type),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                title,
                style: GoogleFonts.heebo(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    rating != null ? rating : '--',
                    style: GoogleFonts.heebo(
                      fontSize: 13,
                      height: 1.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
