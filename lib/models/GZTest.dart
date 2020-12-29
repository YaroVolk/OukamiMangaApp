class GZTest {
  // ignore: non_constant_identifier_names
  final String manga_endpoint, image, chapter, title, type, rating;

  GZTest({
    // ignore: non_constant_identifier_names
    this.manga_endpoint,
    this.image,
    this.chapter,
    this.title,
    this.rating,
    this.type,
  });

  factory GZTest.fromJson(Map<String, dynamic> json) {
    return GZTest(
      manga_endpoint: json['mJLink'],
      chapter: json['latest'],
      image: json['cover'],
      rating: json['r'],
      title: json['name'],
      type: json['m'],
    );
  }
}
