class HomeManga {
  // ignore: non_constant_identifier_names
  final String manga_endpoint, image, chapter, title, type, rating;

  HomeManga({
    // ignore: non_constant_identifier_names
    this.manga_endpoint,
    this.image,
    this.chapter,
    this.title,
    this.rating,
    this.type,
  });

  factory HomeManga.fromJson(Map<String, dynamic> json) {
    return HomeManga(
      manga_endpoint: json['endpoint'],
      chapter: json['chapter'],
      image: json['thumb'],
      rating: json['updated_on'],
      title: json['title'],
      type: json['type'],
    );
  }
}
