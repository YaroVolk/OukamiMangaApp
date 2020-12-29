import 'dart:io';

import 'package:Oukami/bloc/BlocDownload.dart';
import 'package:Oukami/config/Config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class DownloadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<BlocDownloadAlredy, List<Map>>(
      builder: (context, state) => state.length != 0
          ? SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.length,
                    itemBuilder: (context, index) => ListItem(
                      width: width,
                      data: state[index],
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: IconButton(
                        icon: Icon(
                          Feather.alert_circle,
                          color: BaseColor,
                          size: 50,
                        ),
                        onPressed: () {}),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 22.0),
                    child: Text(
                      'Download list is empty',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Text(
                    'Please select your Manga.',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.5,
                    ),
                  ),
                  Text(
                    'Then press to the download button',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.5,
                    ),
                  ),
                  Text(
                    'in the right corner.',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.5,
                    ),
                  ),
                  Text(
                    'Enjoy!',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.5,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    Key key,
    @required this.width,
    this.data,
  }) : super(key: key);

  final double width;
  final Map data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Modular.to.pushNamed('/downloadedchapter', arguments: {
          'title': data['title'],
          'folderPath': data['folderPath'],
        });
      },
      child: Container(
        width: width,
        height: width * .22,
        child: Row(
          children: [
            Image.file(
              File(data['imagePath']),
              width: width * .22,
              height: width * .22,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Theme.of(context).primaryColor.withOpacity(.1)
                          : Theme.of(context)
                              .textSelectionHandleColor
                              .withOpacity(.1),
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 6.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['title'],
                      style: GoogleFonts.heebo(
                        fontSize: 20,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      data['author'],
                      style: GoogleFonts.heebo(
                        fontSize: 16,
                        color: BaseColor,
                        fontWeight: FontWeight.w800
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      data['dateModified'],
                      style: GoogleFonts.heebo(
                        fontSize: 16,
                        color: BaseColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
