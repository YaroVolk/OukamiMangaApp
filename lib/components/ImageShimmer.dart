import 'package:Oukami/config/Config.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageShimmer extends StatelessWidget {
  ImageShimmer({this.width, this.height});

  final double width, height;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(
        colors: [
          BaseColor.withOpacity(.6),
          BGColor,
          BaseColor.withOpacity(.3),
        ],
        stops: [.4, .5, .6],
        begin: Alignment(-1, -1),
        end: Alignment(1, 1),
      ),
      period: Duration(seconds: 2),
      child: Container(
        width: width,
        height: height,
        color: BaseColor.withOpacity(.5),
      ),
    );
  }
}
