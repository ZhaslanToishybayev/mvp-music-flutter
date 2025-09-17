MVP Music App (Flutter)

This repository contains a Flutter MVP music app with synced lyrics, powered by iTunes Search API and LRCLIB.

Requirements
- Flutter (stable channel)

Getting Started
- Run: `cd mvp_music && flutter run -d chrome` (or `-d windows` / `-d <android>`)
- Analyze: `flutter analyze`
- Format: `dart format .`
- Test: `flutter test`

Features
- Search via iTunes API and play 30–60s previews
- Now Playing screen: play/pause/seek, progress, next/prev, queue
- Synced lyrics (LRCLIB) with active line highlighting and auto-scroll
- Tap a lyric line to seek
- Dark theme by default
- Background playback metadata (notifications/lock screen)

Limitations
- Previews may be unavailable for some tracks
- LRCLIB can return no synced lyrics for some songs

Specs
- Source of truth: `spec/` (see `spec/specs/2025-09-14-mvp-player-and-lyrics.md`)

CI
- GitHub Actions workflow runs `flutter analyze` and `flutter test`

Troubleshooting
- If Flutter SDK is missing, install from flutter.dev and ensure `flutter doctor` is green
- For Android/iOS background controls, platform setup may be required (see plugin docs)
