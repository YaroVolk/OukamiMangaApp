import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemCard extends StatelessWidget {
  ItemCard(
      {this.title,
      this.color,
      this.rightWidget,
      this.callback,
      this.textColor});

  final Color color;
  final Color textColor;
  final String title;
  final Widget rightWidget;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 60,
        color: color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 24),
              child: Center(
                child: Text(
                  title,
                  style: GoogleFonts.heebo(
                    fontSize: 18,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 24),
              child: rightWidget,
            )
          ],
        ),
      ),
      onTap: callback,
    );
  }
}
