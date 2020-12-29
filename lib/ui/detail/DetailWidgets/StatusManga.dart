import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusManga extends StatelessWidget {
  const StatusManga({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
      decoration: BoxDecoration(
        color: text.toLowerCase() != 'ongoing' ? Colors.red : Colors.blue,
        borderRadius: BorderRadius.circular(5.6),
      ),
      child: Text(
        text,
        style: GoogleFonts.heebo(fontSize: 13.0, color: Colors.white),
      ),
    );
  }
}
