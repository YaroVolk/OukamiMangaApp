import 'package:Oukami/config/Config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Oukami/components/MangaType.dart';
import 'package:Oukami/components/ImageShimmer.dart';

class SubBody extends StatelessWidget {
  const SubBody({
    Key key,
    @required this.width,
    this.image,
    this.title,
    this.type,
    this.chapter,
    this.mangaId,
    this.rating,
  }) : super(key: key);

  final double width;
  final String image, type, title, chapter, mangaId, rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: () => Modular.to.pushNamed('/detailmanga', arguments: {
              'image': image,
              'title': title,
              'linkId': mangaId,
            }),
            child: Container(
              width: (width * .5) - 12.0,
              alignment: Alignment.center,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                              width: (width * .464) - 12.0,
                              height: width * .62,
                              useOldImageOnUrlChange: true,
                              placeholder: (_, __) => ImageShimmer(
                                width: (width * .464) - 12.0,
                                height: width * .62,
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
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Ch.$chapter',
                          style: GoogleFonts.heebo(
                            fontSize: 13,
                            height: 1.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        rating != null
                            ? Container(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 18,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      rating,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context)
                                            .textSelectionHandleColor
                                            .withOpacity(.6),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 12.0),
        ],
      ),
    );
  }
}
