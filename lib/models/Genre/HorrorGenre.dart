class HorrorGenre {
  // ignore: non_constant_identifier_names
  final String chapter, image, rating, type, manga_endpoint, title;

  HorrorGenre({
    this.chapter,
    this.image,
    this.type,
    // ignore: non_constant_identifier_names
    this.manga_endpoint,
    this.title,
    this.rating,
  });

  factory HorrorGenre.fromJson(Map<String, dynamic> json) {
    return HorrorGenre(
      chapter: json['chapters'],
      image: json['image'],
      type: json['type'],
      manga_endpoint: json['manga_endpoint'],
      title: json['title'],
      rating: json['rating']
    );
  }
}
