import 'package:Oukami/config/Config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:Oukami/bloc/BlocFavorite.dart';
import 'package:Oukami/database/FavoriteData.dart';
import 'package:Oukami/models/detail_comic.dart';

class FavouriteIcon extends StatelessWidget {
  const FavouriteIcon({
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
  final DetailComic detail;
  final String mangaId;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isLoaded
            ? BlocBuilder<BlocFavorite, List<Map>>(
                builder: (context, state) {
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

                  return FlatButton(
                    child: Icon(isFavorited ? Feather.check : Icons.bookmark,
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
                              currentId: detail.listChapters.first.linkId,
                              detailChapter: detail.listChapters.first.chapter,
                              image: detail.image,
                              title: detail.title,
                              type: detail.type,
                              context: context,
                            );
                    },
                  );
                },
              )
            : Container(),
      ],
    );
  }
}
