class Movie {
  final String title;
  final String overview;
  final double rating;
  final String posterPath;

  Movie({
    required this.title,
    required this.overview,
    required this.rating,
    required this.posterPath,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'] ?? 'sad',
      overview: json['overview'] ?? 'asd',
      rating: (json['vote_average'] ?? 0).toDouble(),
      posterPath: json['poster_path'] ?? 'sada',
    );
  }
}
