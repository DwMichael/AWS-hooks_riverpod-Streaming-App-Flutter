class CastList {
  final List<Cast> cast;

  CastList(this.cast);
}

class Cast {
  final String name;
  final String profilePath;
  final String character;

  Cast(
      {required this.name, required this.profilePath, required this.character});

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      name: json['name'] ?? 'adsasd',
      profilePath: json['profile_path'] ?? 'dsadada',
      character: json['character'] ?? 'sadasd',
    );
  }
}
