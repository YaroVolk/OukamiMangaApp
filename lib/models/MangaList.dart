class MangaList {
  // ignore: non_constant_identifier_names
  final String manga_endpoint, image, chapter, title, type, rating;

  MangaList({
    // ignore: non_constant_identifier_names
    this.manga_endpoint,
    this.image,
    this.chapter,
    this.title,
    this.rating,
    this.type,
  });

  factory MangaList.fromJson(Map<String, dynamic> json) {
    return MangaList(
      manga_endpoint: json['manga_endpoint'],
      chapter: json['chapter'],
      image: json['image'],
      rating: json['rating'],
      title: json['title'],
      type: json['type'],
    );
  }
}
