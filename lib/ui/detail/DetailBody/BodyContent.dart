import 'package:Oukami/models/DetailManga.dart';
import 'package:Oukami/ui/detail/DetailBody/ContentManga.dart';
import 'package:Oukami/ui/detail/DetailBody/TabContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class BodyContent extends StatelessWidget {
  const BodyContent({
    Key key,
    this.width,
    this.setState,
    this.isLoaded,
    this.detail,
    this.mangaId,
    String title,
  }) : super(key: key);

  final Function setState;
  final bool isLoaded;
  final double width;
  final DetailManga detail;
  final String mangaId;

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: TabContainer(
        width: width,
        setState: setState,
        isLoaded: isLoaded,
        detail: detail,
        mangaId: mangaId,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) => isLoaded
              ? ContentManga(
                  width: width,
                  detail: detail,
                  mangaId: mangaId,
                )
              : Container(
                  width: width,
                  height: kToolbarHeight * 4,
                  child: Center(child: CircularProgressIndicator()),
                ),
          childCount: 1,
        ),
      ),
    );
  }
}
