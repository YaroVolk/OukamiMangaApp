class LatestChapterManga {
  // ignore: non_constant_identifier_names
  final String title, manga_endpoint, image, hotTag, type;
  final List<ChapterList> chapters;

  LatestChapterManga({
    this.title,
    // ignore: non_constant_identifier_names
    this.manga_endpoint,
    this.image,
    this.hotTag,
    this.type,
    this.chapters,
  });

  factory LatestChapterManga.fromJson(Map<String, dynamic> json) {
    return LatestChapterManga(
      title: json["title"],
      manga_endpoint: json["manga_endpoint"],
      image: json["image"],
      hotTag: json["hotTag"],
      type: json["type"],
      chapters: json['listNewChapter']
          .map<ChapterList>((e) => ChapterList.fromJson(e))
          .toList(),
    );
  }
}

class ChapterList {
  ChapterList({
    this.chapterName,
    this.chapterEndpoint,
    this.updatedOn,
  });

  final String chapterName;
  final String chapterEndpoint;
  final String updatedOn;

  factory ChapterList.fromJson(Map<String, dynamic> json) {
    return ChapterList(
      chapterName: json["chapterName"],
      chapterEndpoint: json["chapter_endpoint"],
      updatedOn: json["updatedOn"],
    );
  }
}
