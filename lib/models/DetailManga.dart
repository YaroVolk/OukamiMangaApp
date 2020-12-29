class DetailManga {
  final String author,
      image,
      rating,
      released,
      description,
      status,
      title,
      type,
      lastUpdated;
  final List<GenreListDetail> genreList;
  final List<ChapterListDetail> chapterList;

  DetailManga({
    this.author,
    this.image,
    this.rating,
    this.released,
    this.description,
    this.status,
    this.title,
    this.type,
    this.lastUpdated,
    this.genreList,
    this.chapterList,
  });

  factory DetailManga.fromJson(Map<String, dynamic> json) {
    return DetailManga(
      author: json['author'],
      image: json['image'],
      rating: json['rating'],
      released: json['released'],
      description: json['description'],
      status: json['status'],
      title: json['title'],
      type: json['type'],
      lastUpdated: json['lastUpdated'],
      genreList: json['genreList']
          .map<GenreListDetail>((e) => GenreListDetail.fromJson(e))
          .toList(),
      chapterList: json['chapterList']
          .map<ChapterListDetail>((e) => ChapterListDetail.fromJson(e))
          .toList(),
    );
  }
}

class ChapterListDetail {
  // ignore: non_constant_identifier_names
  final String chapterName, chapter_endpoint, updatedOn;

  ChapterListDetail({
    this.chapterName,
    // ignore: non_constant_identifier_names
    this.chapter_endpoint,
    this.updatedOn,
  });

  factory ChapterListDetail.fromJson(Map<String, dynamic> json) {
    return ChapterListDetail(
      chapterName: json['chapterName'],
      chapter_endpoint: json['chapter_endpoint'],
      updatedOn: json['updatedOn'],
    );
  }
}

class GenreListDetail {
  // ignore: non_constant_identifier_names
  final String genreName, genre_endpoint;

  GenreListDetail({
    this.genreName,
    // ignore: non_constant_identifier_names
    this.genre_endpoint,
  });

  factory GenreListDetail.fromJson(Map<String, dynamic> json) {
    return GenreListDetail(
      genreName: json['genreName'],
      genre_endpoint: json['genre_endpoint'],
    );
  }

  Map<String, dynamic> toJson() => {
        "genreName": genreName,
        "genre_endpoint": genre_endpoint,
      };
}
