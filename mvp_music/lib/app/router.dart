import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvp_music/features/library/library_screen.dart';
import 'package:mvp_music/features/player/now_playing_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LibraryScreen(),
      ),
      GoRoute(
        path: '/now',
        builder: (context, state) => const NowPlayingScreen(),
      ),
    ],
  );
});
