import 'package:Oukami/config/Config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MangaType extends StatelessWidget {
  const MangaType({Key key, this.text, this.mini = false})
      : super(key: key);

  final String text;
  final bool mini;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: text.toLowerCase() == 'manhua'
            ? Colors.red[900]
            : text.toLowerCase() == 'manhwa' ? Colors.tealAccent[700] : BaseColor,
        borderRadius: BorderRadius.circular(3),
      ),
      alignment: Alignment.center,
      child: Text(
        text.toUpperCase(),
        style: GoogleFonts.heebo(
          fontSize: mini == false ? 10 : 7,
          color:BGColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
