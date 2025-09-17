import 'dart:async';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:mvp_music/core/models/track.dart';

class AudioPlayerState {
  final bool isPlaying;
  final ProcessingState processingState;
  final Duration position;
  final Duration duration;
  final Track? currentTrack;
  final List<Track> queue;
  final int currentIndex;

  const AudioPlayerState({
    required this.isPlaying,
    required this.processingState,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.currentTrack,
    this.queue = const [],
    this.currentIndex = 0,
  });

  AudioPlayerState copyWith({
    bool? isPlaying,
    ProcessingState? processingState,
    Duration? position,
    Duration? duration,
    Track? currentTrack,
    List<Track>? queue,
    int? currentIndex,
  }) {
    return AudioPlayerState(
      isPlaying: isPlaying ?? this.isPlaying,
      processingState: processingState ?? this.processingState,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      currentTrack: currentTrack ?? this.currentTrack,
      queue: queue ?? this.queue,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}

class PlayerController extends Notifier<AudioPlayerState> {
  late final AudioPlayer _player;
  StreamSubscription<PlayerState>? _playerStateSubscription;
  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<Duration?>? _durationSubscription;

  @override
  AudioPlayerState build() {
    _player = AudioPlayer();
    _initializePlayer();
    return const AudioPlayerState(
      isPlaying: false,
      processingState: ProcessingState.idle,
    );
  }

  Future<void> _initializePlayer() async {
    try {
      final session = await AudioSession.instance;
      await session.configure(const AudioSessionConfiguration.music());
      
      _playerStateSubscription = _player.playerStateStream.listen((playerState) {
        state = state.copyWith(
          isPlaying: playerState.playing,
          processingState: playerState.processingState,
        );
      });

      _positionSubscription = _player.positionStream.listen((position) {
        state = state.copyWith(position: position);
      });

      _durationSubscription = _player.durationStream.listen((duration) {
        state = state.copyWith(duration: duration ?? Duration.zero);
      });
    } catch (e) {
      debugPrint('Error initializing player: $e');
    }
  }

  Future<void> playTrack(Track track) async {
    try {
      if (track.previewUrl == null) {
        throw Exception('No preview URL available for this track');
      }

      final mediaItem = MediaItem(
        id: track.id.toString(),
        title: track.title,
        artist: track.artist,
        artUri: Uri.parse(track.artworkUrl),
      );

      await _player.setAudioSource(
        AudioSource.uri(
          Uri.parse(track.previewUrl!),
          tag: mediaItem,
        ),
      );

      state = state.copyWith(
        currentTrack: track,
        queue: [track],
        currentIndex: 0,
      );

      await _player.play();
    } catch (e) {
      debugPrint('Error playing track: $e');
      throw _mapError(e);
    }
  }

  Future<void> play() async {
    try {
      await _player.play();
    } catch (e) {
      debugPrint('Error playing: $e');
    }
  }

  Future<void> pause() async {
    try {
      await _player.pause();
    } catch (e) {
      debugPrint('Error pausing: $e');
    }
  }

  Future<void> seek(Duration position) async {
    try {
      await _player.seek(position);
    } catch (e) {
      debugPrint('Error seeking: $e');
    }
  }

  Future<void> stop() async {
    try {
      await _player.stop();
    } catch (e) {
      debugPrint('Error stopping: $e');
    }
  }

  String _mapError(dynamic error) {
    if (error.toString().contains('autoplay')) {
      return 'Web autoplay blocked. Please click play manually.';
    }
    return 'Playback error: ${error.toString()}';
  }

  void dispose() {
    _playerStateSubscription?.cancel();
    _positionSubscription?.cancel();
    _durationSubscription?.cancel();
    _player.dispose();
  }
}

final playerControllerProvider = NotifierProvider<PlayerController, AudioPlayerState>(
  PlayerController.new,
);