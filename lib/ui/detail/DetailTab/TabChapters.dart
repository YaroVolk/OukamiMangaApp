
import 'package:Oukami/bloc/BlocWidget.dart';
import 'package:Oukami/models/DetailManga.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Oukami/bloc/BlocChapter.dart';

class TabChapters extends StatefulWidget {
  final DetailManga detail;
  final String mangaId;

  TabChapters({
    this.detail,
    this.mangaId,
  });

  @override
  _TabChaptersState createState() => _TabChaptersState();
}

class _TabChaptersState extends State<TabChapters> {
  var controller = ScrollController();

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
            child: BlocBuilder<BlocChapterReverse, bool>(
              builder: (ctx, reverse) => Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: kToolbarHeight - 10,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Theme.of(context)
                              .textSelectionHandleColor
                              .withOpacity(.2),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            '${widget.detail.chapterList.length} Chapters',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Theme.of(context)
                                  .textSelectionHandleColor
                                  .withOpacity(.6),
                            ),
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(
                              Icons.swap_vert,
                              color: Theme.of(context)
                                  .textSelectionHandleColor
                                  .withOpacity(.6),
                            ),
                            onPressed: () =>
                                Modular.get<BlocChapterReverse>().add(!reverse),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: BlocBuilder<BlocChapter, List<String>>(
                        builder: (context, state) => ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          reverse: reverse,
                          itemCount: widget.detail.chapterList.length,
                          itemBuilder: (context, idx) {
                            var isReaded = state.indexOf(widget
                                    .detail.chapterList[idx].chapterName) >=
                                0;

                            return InkWell(
                              onTap: () => Modular.to.pushNamed(
                                '/readchapter',
                                arguments: {
                                  'currentId': widget
                                      .detail.chapterList[idx].chapter_endpoint,
                                  'mangaId': widget.mangaId,
                                },
                              ),
                              child: Container(
                                height: kToolbarHeight + 10,
                                decoration: BoxDecoration(
                                  color: isReaded
                                      ? Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Theme.of(context)
                                              .textSelectionHandleColor
                                              .withOpacity(.03)
                                          : Theme.of(context)
                                              .textSelectionColor
                                              .withOpacity(.2)
                                      : Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Theme.of(context).textSelectionColor
                                          : Colors.transparent,
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Theme.of(context)
                                          .textSelectionHandleColor
                                          .withOpacity(.1),
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        // 'Chapter ' +
                                        widget
                                            .detail.chapterList[idx].chapterName
                                            .toString(),
                                        style:
                                            GoogleFonts.poppins(fontSize: 14.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
