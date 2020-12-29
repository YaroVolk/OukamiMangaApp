import 'dart:ui';

import 'package:Oukami/config/Config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthorText extends StatelessWidget {
  const AuthorText({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      'By $text',
      style: GoogleFonts.heebo(
        fontSize: 18.0,
        color: BaseColor,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
