import 'package:Oukami/components/ImageShimmer.dart';
import 'package:Oukami/config/Config.dart';
import 'package:Oukami/models/LatestChapterManga.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class LatestChapterSlider extends StatelessWidget {
  LatestChapterSlider({
    this.width,
    this.data,
  });

  final double width;
  final List<LatestChapterManga> data;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: data.map((e) {
            return ItemLatest(
              width: width,
              title: e.title,
              image: e.image,
              listChapter: e.chapters,
              manga_endpoint: e.manga_endpoint,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ItemLatest extends StatelessWidget {
  const ItemLatest({
    Key key,
    @required this.width,
    this.title,
    this.image,
    // ignore: non_constant_identifier_names
    this.manga_endpoint,
    this.listChapter,
  }) : super(key: key);

  final double width;
  // ignore: non_constant_identifier_names
  final String title, image, manga_endpoint;
  final List<ChapterList> listChapter;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
      child: Column(
        children: [
          Container(
            width: width,
            height: (width * .35) + 10,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Theme.of(context)
                      .textSelectionHandleColor
                      .withOpacity(.04),
                ),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: InkWell(
                    onTap: () => Modular.to.pushNamed(
                      '/detailmanga',
                      arguments: {
                        'image': image,
                        'title': title,
                        'manga_endpoint': manga_endpoint,
                      },
                    ),
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            width: width * .225,
                            height: (width * .35) + 10,
                            child: Stack(
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
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
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
                                  Expanded(
                                    child: Column(
                                      children: listChapter
                                          .map(
                                            (e) => SingleChapterLink(
                                              title: e.chapterName,
                                              time: e.updatedOn,
                                              mangaId: manga_endpoint,
                                              currentId: e.chapterEndpoint,
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}

class SingleChapterLink extends StatelessWidget {
  const SingleChapterLink({
    Key key,
    this.title,
    this.time,
    this.mangaId,
    this.currentId,
  }) : super(key: key);

  final String title, time, mangaId, currentId;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Modular.to.pushNamed(
              '/readmanga',
              arguments: {
                'mangaId': mangaId,
                'currentId': currentId,
              },
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color:
                    BaseColor.withOpacity(.07),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                title,
                style: GoogleFonts.heebo(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: BaseColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Text(
            time,
            style: GoogleFonts.heebo(
              fontWeight: FontWeight.w400,
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: BaseColor,
            ),
          ),
        ],
      ),
    );
  }
}
