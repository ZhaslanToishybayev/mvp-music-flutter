import 'package:dio/dio.dart';
import 'package:mvp_music/core/models/track.dart';

class LyricsApi {
  final Dio _dio = Dio();

  Future<String?> getLyrics(Track track) async {
    try {
      // Step 1: Search for lyrics
      final searchResponse = await _dio.get(
        'https://lrclib.net/api/search',
        queryParameters: {
          'track_name': track.title,
          'artist_name': track.artist,
          'duration': track.durationMs != null ? track.durationMs! ~/ 1000 : 30,
        },
      );

      final results = searchResponse.data as List<dynamic>;
      if (results.isEmpty) return null;

      // Step 2: Get lyrics by ID
      final lyricsId = results.first['id'];
      final lyricsResponse = await _dio.get(
        'https://lrclib.net/api/get/$lyricsId',
      );

      return lyricsResponse.data['syncedLyrics'] as String?;
    } catch (e) {
      return null;
    }
  }
}
