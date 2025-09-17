import 'package:dio/dio.dart';
import 'package:mvp_music/core/models/track.dart';

class ItunesApi {
  final Dio _dio = Dio();

  Future<List<Track>> searchTracks(
    String query, {
    String? genre,
    int? year,
    bool? explicit,
  }) async {
    try {
      final params = <String, dynamic>{
        'term': query,
        'media': 'music',
        'limit': 25,
      };
      
      if (genre != null && genre.isNotEmpty) {
        params['attribute'] = 'genreTerm';
        params['term'] = '$query $genre';
      }
      
      if (year != null) {
        params['year'] = year;
      }
      
      if (explicit != null) {
        params['explicit'] = explicit ? 'Yes' : 'No';
      }

      final response = await _dio.get(
        'https://itunes.apple.com/search',
        queryParameters: params,
      );

      final results = response.data['results'] as List<dynamic>;
      return results
          .map((json) => Track.fromItunesJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to search tracks: $e');
    }
  }
}
