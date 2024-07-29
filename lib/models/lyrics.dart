class Lyrics {
  final String title;
  final String lyrics;

  Lyrics({required this.title, required this.lyrics});

  factory Lyrics.fromJson(Map<String, dynamic> json) {
    return Lyrics(
      title: json['title'],
      lyrics: json['lyrics'],
    );
  }

  // Converts a Lyrics instance to a JSON object
  Map<String, dynamic> toJson() => {
        'title': title,
        'lyrics': lyrics,
      };
}
