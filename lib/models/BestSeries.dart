class BestSeries {
  // ignore: non_constant_identifier_names
  final String manga_endpoint, image, title, type;

  BestSeries({
    // ignore: non_constant_identifier_names
    this.manga_endpoint,
    this.image,
    this.title,
    this.type,
  });

  factory BestSeries.fromJson(Map<String, dynamic> json) {
    return BestSeries(
      manga_endpoint: json['manga_endpoint'],
      image: json['image'],
      title: json['title'],
      type: json['type'],
    );
  }
}
