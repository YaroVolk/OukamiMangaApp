class FantasyGenre {
  // ignore: non_constant_identifier_names
  final String chapter, image, rating, type, manga_endpoint, title;

  FantasyGenre({
    this.chapter,
    this.image,
    this.type,
    // ignore: non_constant_identifier_names
    this.manga_endpoint,
    this.title,
    this.rating,
  });

  factory FantasyGenre.fromJson(Map<String, dynamic> json) {
    return FantasyGenre(
      chapter: json['chapters'],
      image: json['image'],
      type: json['type'],
      manga_endpoint: json['manga_endpoint'],
      title: json['title'],
      rating: json['rating']
    );
  }
}
