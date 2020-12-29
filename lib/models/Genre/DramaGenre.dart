class DramaGenre {
  // ignore: non_constant_identifier_names
  final String chapter, image, rating, type, manga_endpoint, title;

  DramaGenre({
    this.chapter,
    this.image,
    this.type,
    // ignore: non_constant_identifier_names
    this.manga_endpoint,
    this.title,
    this.rating,
  });

  factory DramaGenre.fromJson(Map<String, dynamic> json) {
    return DramaGenre(
      chapter: json['chapters'],
      image: json['image'],
      type: json['type'],
      manga_endpoint: json['manga_endpoint'],
      title: json['title'],
      rating: json['rating']
    );
  }
}
