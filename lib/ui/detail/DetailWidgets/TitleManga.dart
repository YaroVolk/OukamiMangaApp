import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleManga extends StatelessWidget {
  const TitleManga({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.heebo(
        fontSize: 24.0,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
