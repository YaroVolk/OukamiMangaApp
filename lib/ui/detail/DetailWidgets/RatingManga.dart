import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RatingManga extends StatelessWidget {
  const RatingManga({
    Key key,
    this.value,
  }) : super(key: key);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 6.0),
      child: Row(
        children: [
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 15,
          ),
          SizedBox(width: 4.0),
          Text(
            value,
            style: GoogleFonts.heebo(
              fontSize: 13.0,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
