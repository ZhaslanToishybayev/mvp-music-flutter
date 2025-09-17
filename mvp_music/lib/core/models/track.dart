
class Track {
  final int id;
  final String title;
  final String artist;
  final String artworkUrl;
  final String? previewUrl;
  final int? durationMs;
  final String? primaryGenre;
  final int? releaseYear;
  final bool? isExplicit;

  const Track({
    required this.id,
    required this.title,
    required this.artist,
    required this.artworkUrl,
    required this.previewUrl,
    this.durationMs,
    this.primaryGenre,
    this.releaseYear,
    this.isExplicit,
  });

  factory Track.fromItunesJson(Map<String, dynamic> j) {
    return Track(
      id: j['trackId'] ?? j['collectionId'] ?? 0,
      title: j['trackName'] ?? j['collectionName'] ?? 'Unknown',
      artist: j['artistName'] ?? 'Unknown',
      artworkUrl: (j['artworkUrl100'] ?? j['artworkUrl60'] ?? '')
          .toString()
          .replaceAll('100x100', '600x600'),
      previewUrl: j['previewUrl'] as String?,
      durationMs: (j['trackTimeMillis'] as num?)?.toInt(),
      primaryGenre: j['primaryGenreName'] as String?,
      releaseYear: DateTime.tryParse(j['releaseDate'] as String? ?? '')?.year,
      isExplicit: (j['trackExplicitness'] == 'explicit' || j['collectionExplicitness'] == 'explicit'),
    );
  }

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      id: json['id'] as int,
      title: json['title'] as String,
      artist: json['artist'] as String,
      artworkUrl: json['artworkUrl'] as String,
      previewUrl: json['previewUrl'] as String?,
      durationMs: json['durationMs'] as int?,
      primaryGenre: json['primaryGenre'] as String?,
      releaseYear: json['releaseYear'] as int?,
      isExplicit: json['isExplicit'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'artworkUrl': artworkUrl,
      'previewUrl': previewUrl,
      'durationMs': durationMs,
      'primaryGenre': primaryGenre,
      'releaseYear': releaseYear,
      'isExplicit': isExplicit,
    };
  }
}
