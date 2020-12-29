import 'dart:ui';

import 'package:Oukami/bloc/BlocWidget.dart';
import 'package:Oukami/config/Config.dart';
import 'package:Oukami/models/DetailManga.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key key,
    @required this.sliverBloc,
    @required this.width,
    this.image,
    this.title,
    this.isLoaded,
    this.detail,
  }) : super(key: key);

  final BlocSliver sliverBloc;
  final double width;
  final String image, title;
  final bool isLoaded;
  final DetailManga detail;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: 80,
      child: BlocBuilder<BlocSliver, bool>(
        builder: (context, state) => Container(
          child: Material(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      BlocBuilder<BlocSliver, bool>(
                        bloc: sliverBloc,
                        builder: (context, state) => IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Theme.of(context).brightness ==
                                        Brightness.dark &&
                                    state == true
                                ? Colors.white
                                : Theme.of(context).brightness ==
                                            Brightness.dark &&
                                        state == false
                                    ? Colors.white
                                    : Theme.of(context).brightness ==
                                                Brightness.light &&
                                            state == true
                                        ? DarkColor
                                        : BGColor,
                          ),
                          onPressed: () => Modular.to.pop(),
                          padding: EdgeInsets.only(top: 18),
                          iconSize: 26.0,
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      state
                          ? Flexible(
                              child: Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Text(
                                  title,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 21.0,
                                    color: BGColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                BlocBuilder<BlocSliver, bool>(
                  builder: (context, state) => IconButton(
                    icon: Icon(
                      Icons.file_download,
                      color: Theme.of(context).brightness == Brightness.dark &&
                              state == true
                          ? Colors.white.withOpacity(isLoaded ? 1 : .4)
                          : Theme.of(context).brightness == Brightness.dark &&
                                  state == false
                              ? Colors.white.withOpacity(isLoaded ? 1 : .4)
                              : Theme.of(context).brightness ==
                                          Brightness.light &&
                                      state == true
                                  ? Colors.blueGrey[600]
                                      .withOpacity(isLoaded ? 1 : .4)
                                  : Colors.white.withOpacity(isLoaded ? 1 : .4),
                    ),
                    onPressed: () {
                      if (isLoaded)
                        Modular.to.pushNamed(
                          '/downloadmanga',
                          arguments: {
                            "detail": detail,
                          },
                        );
                    },
                    padding: EdgeInsets.only(top: 18),
                    iconSize: 26.0,
                  ),
                ),
              ],
            ),
          ),
          width: width,
          height: kToolbarHeight,
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            bottom: 8.0,
          ),
          decoration: BoxDecoration(
            color: state ? BaseColor : Colors.transparent,
          ),
        ),
      ),
    );
  }
}
