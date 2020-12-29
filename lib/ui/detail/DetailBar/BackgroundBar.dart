import 'dart:ui';

import 'package:Oukami/bloc/BlocWidget.dart';
import 'package:Oukami/models/DetailManga.dart';
import 'package:Oukami/ui/detail/DetailWidgets/AuthorText.dart';
import 'package:Oukami/ui/detail/DetailWidgets/RatingManga.dart';
import 'package:Oukami/ui/detail/DetailWidgets/StatusManga.dart';
import 'package:Oukami/ui/detail/DetailWidgets/TitleManga.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BackgroundBar extends StatelessWidget {
  const BackgroundBar({
    Key key,
    @required this.width,
    @required this.title,
    @required this.image,
    this.isLoaded,
    this.detail,
  }) : super(key: key);

  final double width;
  final String image, title;
  final bool isLoaded;
  final DetailManga detail;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  image,
                ),
              ),
            ),
            child: BlocBuilder<BlocBlur, double>(
              builder: (context, state) => BackdropFilter(
                filter: ImageFilter.blur(sigmaX: state, sigmaY: state),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.0),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.blueGrey[900].withOpacity(0.9),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.topCenter,
                colors: [
                  Colors.transparent,
                  Colors.blueGrey[800].withOpacity(0.8),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20.0,
          left: 18.0,
          right: 18.0,
          child: Container(
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                isLoaded ? StatusManga(text: detail.status) : Container(),
                TitleManga(text: title),
                AuthorText(text: isLoaded ? detail.author : '-'),
                isLoaded ? RatingManga(value: detail.rating) : Container(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
