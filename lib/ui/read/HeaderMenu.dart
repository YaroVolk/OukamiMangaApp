import 'package:Oukami/config/Config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Oukami/models/detail_chapter.dart';

class HeaderMenu extends StatelessWidget {
  const HeaderMenu({
    Key key,
    @required this.width,
    this.showMenu,
    this.currentChapter,
    this.titleDownloaded,
    this.rootContext,
    this.listChapter,
    this.changeChapter,
  }) : super(key: key);

  final double width;
  final bool showMenu;
  final String currentChapter, titleDownloaded;
  final BuildContext rootContext;
  final List<SelectChapter> listChapter;
  final Function changeChapter;

  void showListChapter() {
    showDialog(
      context: rootContext,
      builder: (ctx) => AlertDialog(
        title: Text('Select Chapter'),
        content: Container(
          child: ListView.builder(
            itemCount: listChapter.length,
            itemBuilder: (ctx, idx) => ListTile(
              title: Text(listChapter[idx].text),
              onTap: () {
                Modular.to.pop();
                changeChapter(id: listChapter[idx].linkId);
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      top: showMenu ? 0 : -(kToolbarHeight + 20),
      child: Container(
        width: width,
        padding: EdgeInsets.only(top: 20),
        height: kToolbarHeight + 20,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topCenter,
            colors: [
              BaseColor.withOpacity(.95),
              GradientColor.withOpacity(.95),
            ],
          ),
          color: BaseColor.withOpacity(.9),
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[800]
                  : Colors.white.withOpacity(.8),
              width: 2,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(width),
                    child: IconButton(
                      icon: Icon(
                        Feather.arrow_left,
                        color: Colors.white,
                      ),
                      onPressed: () => Modular.to.pop(context),
                    ),
                  ),
                  SizedBox(width: 5),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.only(left: 135, top: 5),
                      child: Text(
                        titleDownloaded == null
                            ? 'Chapter $currentChapter'
                            : titleDownloaded,
                        style: GoogleFonts.poppins(
                            fontSize: 19,
                            color: BGColor,
                            fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  // SizedBox(width: 5),
                  // Material(
                  //   color: Colors.transparent,
                  //   borderRadius: BorderRadius.circular(width),
                  //   child: IconButton(
                  //     icon: Icon(
                  //       Feather.menu,
                  //       color: Colors.white,
                  //     ),
                  //     onPressed: showListChapter,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
