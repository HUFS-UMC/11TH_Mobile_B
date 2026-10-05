class Movie {
  const Movie({
    required this.id,
    required this.title,
    required this.genre,
    required this.year,
    required this.duration,
    required this.posterAssetPath,
    required this.rating,
    required this.synopsis,
  });

  final String id;
  final String title;
  final String genre;
  final int year;
  final int duration;
  final String posterAssetPath;
  final double rating;
  final String synopsis;
}
