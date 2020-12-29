import 'package:Oukami/config/Config.dart';
import 'package:Oukami/models/DetailManga.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class FloatingMenu extends StatelessWidget {
  const FloatingMenu({
    Key key,
    @required this.width,
    this.chapter,
    this.mangaId,
  }) : super(key: key);

  final double width;
  final ChapterListDetail chapter;
  final String mangaId;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: width,
        height: kToolbarHeight,
        padding: EdgeInsets.only(right: 10.0, left: 2.0),
        decoration: BoxDecoration(
          color: Theme.of(context).textSelectionColor.withOpacity(0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(width),
                  child: Material(
                    borderRadius: BorderRadius.circular(width),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topCenter,
                          colors: [
                            BaseColor,
                            GradientColor,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(width),
                      ),
                      child: InkWell(
                        onTap: () => Modular.to.pushNamed(
                          '/readchapter',
                          arguments: {
                            'mangaId': mangaId,
                            'currentId': chapter.chapter_endpoint,
                          },
                        ),
                        child: Container(
                          height: kToolbarHeight - 10,
                          alignment: Alignment.center,
                          child: Text(
                            'START READING',
                            style: GoogleFonts.poppins(
                                color: BGColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
