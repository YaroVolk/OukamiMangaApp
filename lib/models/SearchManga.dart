class SearchManga {
  // ignore: non_constant_identifier_names
  final String chapter, image, manga_endpoint, rating, title, type;

  SearchManga({
    this.chapter,
    this.image,
    // ignore: non_constant_identifier_names
    this.manga_endpoint,
    this.rating,
    this.title,
    this.type,
  });

  factory SearchManga.fromJson(Map<String, dynamic> json) {
    return SearchManga(
      type: json['type'],
      title: json['title'],
      rating: json['rating'],
      manga_endpoint: json['manga_endpoint'],
      image: json['image'],
      chapter: json['chapter'],
    );
  }
}
