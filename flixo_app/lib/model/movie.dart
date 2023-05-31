class Movie {
  final int id;
  final String title;
  final String overview;
  final double rating;
  final String posterPath;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.rating,
    required this.posterPath,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? '',
      title: json['title'] ?? ' ',
      overview: json['overview'] ?? ' ',
      rating: (json['vote_average'] ?? 0).toDouble(),
      posterPath: json['poster_path'] ?? ' ',
    );
  }
}
