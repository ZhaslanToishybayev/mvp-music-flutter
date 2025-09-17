import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvp_music/core/models/track.dart';
import 'package:mvp_music/data/sources/itunes_api.dart';
import 'package:mvp_music/features/player/services/audio_player_service.dart';
import 'package:mvp_music/utils/time_format.dart';

class LibraryScreen extends HookConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final searchQuery = useState('');
    final tracks = useState<List<Track>>([]);
    final isLoading = useState(false);
    final error = useState<String?>(null);

    final api = ItunesApi();

    Future<void> searchTracks(String query) async {
      if (query.trim().isEmpty) return;
      
      isLoading.value = true;
      error.value = null;
      
      try {
        final results = await api.searchTracks(query);
        tracks.value = results;
        searchQuery.value = query;
      } catch (e) {
        error.value = e.toString();
      } finally {
        isLoading.value = false;
      }
    }

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('MVP Music'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: _TrackSearchDelegate(
                  onSearch: searchTracks,
                  tracks: tracks.value,
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search for music...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          tracks.value = [];
                          searchQuery.value = '';
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: searchTracks,
            ),
          ),
          Expanded(
            child: _buildContent(
              context,
              tracks.value,
              isLoading.value,
              error.value,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    List<Track> tracks,
    bool isLoading,
    String? error,
  ) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: $error'),
          ],
        ),
      );
    }

    if (tracks.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.music_note, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('Search for music to get started'),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tracks.length,
      itemBuilder: (context, index) {
        final track = tracks[index];
        return _TrackTile(track: track);
      },
    );
  }
}

class _TrackTile extends ConsumerWidget {
  final Track track;

  const _TrackTile({required this.track});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            track.artworkUrl,
            width: 56,
            height: 56,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 56,
                height: 56,
                color: Colors.grey[800],
                child: const Icon(Icons.music_note),
              );
            },
          ),
        ),
        title: Text(
          track.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleMedium,
        ),
        subtitle: Text(
          '${track.artist} · ${mmSsFromMs(track.durationMs)}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodyMedium,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.play_arrow),
          onPressed: () async {
            final playerController = ref.read(playerControllerProvider.notifier);
            await playerController.playTrack(track);
            if (context.mounted) {
              context.push('/now');
            }
          },
        ),
      ),
    );
  }
}

class _TrackSearchDelegate extends SearchDelegate {
  final Function(String) onSearch;
  final List<Track> tracks;

  _TrackSearchDelegate({
    required this.onSearch,
    required this.tracks,
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    onSearch(query);
    return const SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox.shrink();
  }
}
