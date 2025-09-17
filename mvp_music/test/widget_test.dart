import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvp_music/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: MvpMusicApp(),
      ),
    );

    // Verify that our counter starts at 0.
    expect(find.text('MVP Music'), findsOneWidget);
    expect(find.text('Search for music to get started'), findsOneWidget);
  });
}