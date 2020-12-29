import 'package:Oukami/config/Config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class SubHeader extends StatelessWidget {
  const SubHeader({
    Key key,
    this.text,
    this.width,
    this.withNext = true,
    this.action,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final double width;
  final bool withNext;
  final Widget action;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 35,
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      child: action != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  text.toUpperCase(),
                  style: GoogleFonts.heebo(
                    fontSize: 20,
                    color: BaseColor,
                  ),
                ),
                withNext
                    ? IconButton(
                        icon: Icon(
                          Feather.arrow_right,
                          color: BaseColor,
                          size: 26,
                        ),
                        onPressed: () {},
                      )
                    : Container(),
                action,
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text.toUpperCase(),
                  style: GoogleFonts.heebo(fontSize: 20, color: BaseColor),
                ),
                withNext
                    ? IconButton(
                        icon: Icon(
                          Feather.arrow_right,
                          color: BaseColor,
                          size: 26,
                        ),
                        onPressed: onPressed,
                      )
                    : Container(),
              ],
            ),
    );
  }
}
