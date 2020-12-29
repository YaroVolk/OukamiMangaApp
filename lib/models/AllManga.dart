class AllManga {
  // ignore: non_constant_identifier_names
  final String manga_endpoint, image, chapter, title, type, rating;

  AllManga({
    // ignore: non_constant_identifier_names
    this.manga_endpoint,
    this.image,
    this.chapter,
    this.title,
    this.rating,
    this.type,
  });

  factory AllManga.fromJson(Map<String, dynamic> json) {
    return AllManga(
      manga_endpoint: json['endpoint'],
      chapter: json['chapter'],
      image: json['thumb'],
      rating: json['updated_on'],
      title: json['title'],
      type: json['type'],
    );
  }
}
