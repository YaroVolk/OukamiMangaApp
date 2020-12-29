import 'package:Oukami/bloc/BlocDownload.dart';
import 'package:Oukami/config/Config.dart';
import 'package:Oukami/models/DetailManga.dart';
import 'package:Oukami/ui/download/DownloadButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class DownloadPage extends StatefulWidget {
  DownloadPage({this.detail});

  final DetailManga detail;

  @override
  _DownloadMangaPageState createState() => _DownloadMangaPageState();
}

class _DownloadMangaPageState extends State<DownloadPage> {
  List<ChapterListDetail> _checkedList = [];

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  void checkAll() {
    setState(() {
      // ignore: unrelated_type_equality_checks
      if (_checkedList == widget.detail.chapterList) {
        _checkedList = [];
      } else {
        _checkedList = [];
        _checkedList = widget.detail.chapterList;
      }
    });
  }

  void uncheckAll() {
    setState(() {
      _checkedList = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Download'),
        backgroundColor: BaseColor,
        shadowColor: Colors.transparent,
        toolbarHeight: 50,
        actions: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: IconButton(icon: Icon(Feather.filter), onPressed: checkAll),
          ),
        ],
      ),
      body: Stack(
        children: [
          BlocBuilder<BlocDownloadedChapter, List<Map>>(
            builder: (ctx, state) {
              return ListView.builder(
                itemCount: widget.detail.chapterList.length,
                padding: EdgeInsets.only(bottom: width * .21),
                itemBuilder: (context, idx) => state
                            .where((element) =>
                                element['chapterId'] ==
                                '/${widget.detail.chapterList[idx].chapter_endpoint.replaceAll('/', '')}')
                            .toList()
                            .length ==
                        0
                    ? InkWell(
                        onTap: () {},
                        child: CheckboxListTile(
                            title: Text(
                              'Chapter ${widget.detail.chapterList[idx].chapterName}',
                              style: GoogleFonts.heebo(),
                            ),
                            onChanged: (bool value) {
                              setState(() {
                                _checkedList.indexOf(
                                            widget.detail.chapterList[idx]) >=
                                        0
                                    ? _checkedList.removeAt(
                                        _checkedList.indexOf(
                                            widget.detail.chapterList[idx]))
                                    : _checkedList
                                        .add(widget.detail.chapterList[idx]);
                              });
                            },
                            value: _checkedList
                                    .indexOf(widget.detail.chapterList[idx]) >=
                                0),
                      )
                    : Opacity(
                        opacity: 0.4,
                        child: CheckboxListTile(
                          title: Text(
                            'Chapter ${widget.detail.chapterList[idx].chapterName}',
                            style: GoogleFonts.heebo(),
                          ),
                          value: false,
                          onChanged: (bool value) {},
                        ),
                      ),
              );
            },
          ),
          DownloadBottom(
            width: width,
            detail: widget.detail,
            data: _checkedList,
            uncheckAll: uncheckAll,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.dispose();
  }
}
