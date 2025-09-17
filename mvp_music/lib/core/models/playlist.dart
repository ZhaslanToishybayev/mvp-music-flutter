import 'package:mvp_music/core/models/track.dart';

class Playlist {
  final String id;
  String name;
  List<Track> tracks;

  Playlist({required this.id, required this.name, this.tracks = const []});

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['id'] as String,
      name: json['name'] as String,
      tracks: (json['tracks'] as List<dynamic>?)
              ?.map((e) => Track.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'tracks': tracks.map((e) => e.toJson()).toList(),
    };
  }

  Playlist copyWith({String? id, String? name, List<Track>? tracks}) {
    return Playlist(
      id: id ?? this.id,
      name: name ?? this.name,
      tracks: tracks ?? this.tracks,
    );
  }
}
