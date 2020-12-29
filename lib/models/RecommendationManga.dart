class RecommendationManga {
  // ignore: non_constant_identifier_names
  final String manga_endpoint, image, title, type, rating;

  RecommendationManga({
    // ignore: non_constant_identifier_names
    this.manga_endpoint,
    this.image,
    this.title,
    this.rating,
    this.type,
  });

  factory RecommendationManga.fromJson(Map<String, dynamic> json) {
    return RecommendationManga(
      manga_endpoint: json['manga_endpoint'],
      image: json['thumb'],
      rating: json['upload_on'],
      title: json['title'],
      type: json['type'],
    );
  }
}
