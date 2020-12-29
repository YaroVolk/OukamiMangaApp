import 'dart:ui';

import 'package:Oukami/config/Config.dart';
import 'package:Oukami/models/DetailManga.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Oukami/bloc/BlocFavorite.dart';
import 'package:Oukami/database/FavoriteData.dart';

class TabContainer extends StatelessWidget {
  const TabContainer({
    Key key,
    @required this.width,
    this.setState,
    this.isLoaded,
    this.detail,
    this.mangaId,
  }) : super(key: key);

  final double width;
  final Function setState;
  final bool isLoaded;
  final DetailManga detail;
  final String mangaId;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 65,
      decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: BGColor,
            ),
          ),
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[100]
              : BGColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TabBar(
            onTap: (state) {
              setState(() {});
            },
            isScrollable: true,
            indicatorColor: BaseColor,
            labelPadding: EdgeInsets.only(
              bottom: 10,
              left: 20,
              right: 20,
              top: 10,
            ),
            tabs: [
              Tab(
                child: Text(
                  'OVERVIEW',
                  style: GoogleFonts.heebo(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: BaseColor),
                ),
              ),
            ],
          ),
          isLoaded
              ? Container(
                  margin: EdgeInsets.only(left: 5, right: 15, top: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(width),
                    child: Material(
                      child: BlocBuilder<BlocFavorite, List<Map>>(
                        builder: (context, state) {
                          var isFavorited = state
                                  .where(
                                    (element) =>
                                        element['mangaId'] ==
                                        (mangaId.substring(
                                                    mangaId.length - 1) ==
                                                '/'
                                            ? mangaId.replaceAll('/', '')
                                            : mangaId),
                                  )
                                  .toList()
                                  .length >
                              0;

                          return FlatButton(
                            child: Icon(
                                isFavorited ? Feather.check : Icons.bookmark,
                                color: isFavorited ? BGColor : BGColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: isFavorited ? Colors.green[600] : BaseColor,
                            onPressed: () async {
                              isFavorited
                                  ? await FavoriteData.unsaveFavorite(
                                      mangaId: mangaId,
                                    )
                                  : await FavoriteData.saveFavorite(
                                      mangaId: mangaId,
                                      currentId: detail
                                          .chapterList.first.chapter_endpoint,
                                      detailChapter:
                                          detail.chapterList.first.chapterName,
                                      image: detail.image,
                                      title: detail.title,
                                      type: detail.type,
                                      context: context,
                                    );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
