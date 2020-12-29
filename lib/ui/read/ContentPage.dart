import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:Oukami/models/detail_chapter.dart';
import 'package:zoom_widget/zoom_widget.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({
    Key key,
    this.setShowMenu,
    this.showMenu,
    this.images,
    this.downloadedImages,
  }) : super(key: key);

  final Function setShowMenu;
  final bool showMenu;
  final List<ImageChapter> images;
  final List<String> downloadedImages;

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<ContentPage> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    onScrollListen();
  }

  onScrollListen() {
    _controller.addListener(() {
      if (_controller.position.atEdge && _controller.position.pixels == 0) {
        widget.setShowMenu(true);
      }

      if (_controller.position.pixels != 0 && widget.showMenu == true) {
        widget.setShowMenu(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Positioned.fill(
      child: Zoom(
        width: width + (width * .6),
        height: height + (height * .6),
        backgroundColor: Theme.of(context).primaryColor,
        opacityScrollBars: 0.9,
        scrollWeight: 10.0,
        centerOnScale: false,
        enableScroll: false,
        doubleTapZoom: false,
        zoomSensibility: 1.3,
        initZoom: 0.0,
        onPositionUpdate: (position) {},
        onScaleUpdate: (scale, zoom) {},
        child: Container(
          height: height,
          child: SingleChildScrollView(
            controller: _controller,
            child: GestureDetector(
              onTap: () {
                widget.setShowMenu(!widget.showMenu);
              },
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.downloadedImages == null
                    ? widget.images.length
                    : widget.downloadedImages.length,
                itemBuilder: (ctx, idx) => widget.downloadedImages == null
                    ? CachedNetworkImage(
                        imageUrl: widget.images[idx].link,
                        fit: BoxFit.cover,
                        placeholder: (context, text) => Container(
                          color: Theme.of(context)
                              .textSelectionHandleColor
                              .withOpacity(.0),
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.width / 2.5),
                          child: Center(
                            child: SizedBox(
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ),
                      )
                    : Image.file(
                        File(widget.downloadedImages[idx]),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
