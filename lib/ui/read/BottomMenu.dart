import 'package:Oukami/config/Config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Oukami/bloc/BlocFavorite.dart';
import 'package:Oukami/database/FavoriteData.dart';
import 'package:Oukami/models/detail_comic.dart';

class BottomMenu extends StatelessWidget {
  const BottomMenu({
    Key key,
    @required this.width,
    this.showMenu,
    this.nextId,
    this.prevId,
    this.changeChapter,
    this.isLoaded,
    this.mangaId,
    this.detail,
  }) : super(key: key);

  final double width;
  final bool showMenu, isLoaded;
  final String prevId, nextId, mangaId;
  final Function changeChapter;
  final DetailComic detail;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      bottom: showMenu ? 0 : -(kToolbarHeight),
      child: Container(
        width: width,
        height: kToolbarHeight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topCenter,
            colors: [
              BaseColor.withOpacity(.95),
              GradientColor.withOpacity(.95),
            ],
          ),
          border: Border(
            top: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[800]
                  : BGColor.withOpacity(.95),
              width: 2,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(width),
              child: IconButton(
                padding: EdgeInsets.only(bottom: 5),
                icon: Icon(
                  Icons.arrow_left,
                  color: prevId != null
                      ? Colors.white
                      : Colors.white.withOpacity(.5),
                  size: 35,
                ),
                onPressed: () {
                  if (prevId != null && isLoaded) changeChapter(id: prevId);
                },
              ),
            ),
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(width),
              child: BlocBuilder<BlocFavorite, List<Map>>(
                builder: (ctx, state) {
                  var isFavorited = state
                          .where(
                            (element) =>
                                element['mangaId'] ==
                                (mangaId.substring(mangaId.length - 1) == '/'
                                    ? mangaId.replaceAll('/', '')
                                    : mangaId),
                          )
                          .toList()
                          .length >
                      0;

                  return IconButton(
                    icon: Icon(
                      isFavorited ? Icons.bookmark : Icons.bookmark_border,
                      color: isFavorited ? Colors.green : Colors.white,
                      size: 35,
                    ),
                    onPressed: () async {
                      if (detail != null) {
                        isFavorited
                            ? await FavoriteData.unsaveFavorite(
                                mangaId: mangaId,
                              )
                            : await FavoriteData.saveFavorite(
                                mangaId: mangaId,
                                currentId: detail.listChapters.first.linkId,
                                detailChapter:
                                    detail.listChapters.first.chapter,
                                image: detail.image,
                                title: detail.title,
                                type: detail.type,
                                context: context,
                              );
                      }
                    },
                  );
                },
              ),
            ),
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(width),
              child: IconButton(
                padding: EdgeInsets.only(bottom: 5),
                icon: Icon(
                  Icons.arrow_right,
                  color: nextId != null
                      ? Colors.white
                      : Colors.white.withOpacity(.5),
                  size: 35,
                ),
                onPressed: () {
                  if (nextId != null && isLoaded) changeChapter(id: nextId);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
