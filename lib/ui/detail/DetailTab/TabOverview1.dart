import 'package:Oukami/database/MangaData.dart';
import 'package:Oukami/bloc/BlocWidget.dart';
import 'package:Oukami/config/Config.dart';
import 'package:Oukami/models/DetailManga.dart';
import 'package:Oukami/ui/detail/DetailTab/TabChapters.dart';
import 'package:Oukami/ui/detail/DetailTab/TabGenres.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class TabOverview extends StatefulWidget {
  final DetailManga detail;
  final double width;
  final Function setState;
  final bool isLoaded;
  final String mangaId;
  final String image;
  final String title;
  // ignore: non_constant_identifier_names
  final String manga_endpoint;

  TabOverview({
    this.detail,
    this.image,
    this.title,
    // ignore: non_constant_identifier_names
    this.manga_endpoint,
    this.mangaId,
    this.width,
    this.isLoaded,
    this.setState,
  });

  @override
  _TabOverviewState createState() => _TabOverviewState();
}

class _TabOverviewState extends State<TabOverview> {
  var controller = ScrollController();

  double width;
  bool isLoaded = false;
  DetailManga detail = DetailManga();
  GenreListDetail genreListDetail;

  void getData() async {
    detail = await MangaData.getDetailManga(id: widget.manga_endpoint);
    genreListDetail = detail.genreList.first;
    if (this.mounted)
      setState(() {
        isLoaded = true;
      });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.atEdge && controller.position.pixels == 0.0) {
        Future.delayed(Duration(seconds: 0), () {
          Modular.get<BlocScroll>().add(false);
        });
      }

      if (controller.position.atEdge && controller.position.pixels != 0.0) {
        Future.delayed(Duration(seconds: 0), () {
          Modular.get<BlocScroll>().add(false);
        });
      }
    });
  }

  bool onScroll(t) {
    if (t is ScrollEndNotification) {
      Future.delayed(Duration(seconds: 0), () {
        Modular.get<BlocScroll>().add(false);
      });
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocScroll, ScrollPhysics>(
      builder: (context, state) {
        return NotificationListener(
          onNotification: onScroll,
          child: SingleChildScrollView(
            controller: controller,
            physics: state,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'GENRES',
                    style: GoogleFonts.heebo(
                        fontSize: 21.0,
                        fontWeight: FontWeight.w700,
                        color: BaseColor),
                  ),
                  Container(
                    child: TabGenres(
                      detail: widget.detail,
                      mangaId: widget.mangaId,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'DESCRIPTION',
                    style: GoogleFonts.heebo(
                        fontSize: 21.0,
                        fontWeight: FontWeight.w700,
                        color: BaseColor),
                  ),
                  ExpandText(
                    widget.detail.description,
                    maxLength: 4,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.heebo(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context)
                          .textSelectionHandleColor
                          .withOpacity(.3),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Divider(),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'UPDATED',
                              style: GoogleFonts.heebo(
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.w700,
                                  color: BaseColor),
                            ),
                            Text(
                              widget.detail.lastUpdated,
                              style: GoogleFonts.heebo(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .textSelectionHandleColor
                                    .withOpacity(.3),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'RELEASED',
                              style: GoogleFonts.heebo(
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.w700,
                                  color: BaseColor),
                            ),
                            Text(
                              widget.detail.released,
                              style: GoogleFonts.heebo(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .textSelectionHandleColor
                                    .withOpacity(.3),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    child: TabChapters(
                      detail: widget.detail,
                      mangaId: widget.mangaId,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
