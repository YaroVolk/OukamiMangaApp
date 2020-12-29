
import 'package:Oukami/config/Config.dart';
import 'package:Oukami/models/DetailManga.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class TabGenres extends StatefulWidget {
  final DetailManga detail;
  final String mangaId;

  TabGenres({
    this.detail,
    this.mangaId,
  });

  @override
  _TabGenresState createState() => _TabGenresState();
}

class _TabGenresState extends State<TabGenres> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 2.3,
        crossAxisSpacing: 15,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.detail.genreList.length,
      itemBuilder: (context, idx) {
        return InkWell(
          onTap: () => Modular.to.pushNamed(
            '/homeother',
            arguments: {'title': 'Genres'},
          ),
          child: Chip(
            label: Container(
              width: 130,
              height: 15,
              child: Text(
                widget.detail.genreList[idx].genreName.toString(),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            labelStyle: GoogleFonts.poppins(
              color: BGColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            backgroundColor: BaseColor,
            shadowColor: DarkColor,
            elevation: 1.5,
            materialTapTargetSize: MaterialTapTargetSize.padded,
          ),
        );
      },
    );
  }
}
