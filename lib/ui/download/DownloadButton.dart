import 'package:Oukami/database/DownloadData1.dart';

import 'package:Oukami/config/Config.dart';
import 'package:Oukami/models/DetailManga.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class DownloadBottom extends StatelessWidget {
  const DownloadBottom({
    Key key,
    @required this.width,
    @required this.detail,
    this.data,
    this.uncheckAll,
  }) : super(key: key);

  final double width;
  final DetailManga detail;
  final List<ChapterListDetail> data;
  final Function uncheckAll;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: width,
        height: width * .21,
        color: BaseColor,
        alignment: Alignment.center,
        child: ListTile(
          leading: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: CachedNetworkImage(
                imageUrl: detail.image,
                fit: BoxFit.cover,
                width: width * .145,
                height: width * .145,
              ),
            ),
          ),
          title: Text(
            'Download ${data.length} Chapter',
            style: GoogleFonts.heebo(
              color: Colors.grey[300],
              fontSize: 11,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text(
              detail.title,
              style: GoogleFonts.heebo(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          trailing: Material(
            borderRadius: BorderRadius.circular(10),
            child: Ink(
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : BaseColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {
                  if (data.length != 0)
                    DownloadData().downloadChapter(
                      context: context,
                      data: detail,
                      listData: data,
                      onComplete: uncheckAll,
                    );
                  else
                    Modular.to.pop(context);
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.0, vertical: 7.0),
                  child: Text(
                    'Download',
                    style: GoogleFonts.heebo(
                      color: BaseColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
