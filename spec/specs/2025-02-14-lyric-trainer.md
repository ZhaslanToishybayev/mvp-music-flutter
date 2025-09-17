# Lyric Sync Trainer — Spec

## Context
Glass UI is live, but our lyric timing depends on third-party offsets. We want an in-app trainer so users can align lyrics for any preview and have that offset apply immediately.

## Goals
- Provide a "Lyric Sync" UI accessible from Now Playing to adjust timing while the preview loops.
- Persist user offsets per track for the session and apply them automatically when loading lyrics.
- Keep the experience consistent with the liquid glass aesthetic.

## Acceptance Criteria
- From Now Playing, user can open a Lyric Sync panel (sheet/modal).
- Trainer shows current lyrics list and an offset slider (range at least ±5s) that updates highlight timing in real time.
- Users can tap "Reset" to clear offset or "Save" to close (offset persists for the session).
- Lyrics provider applies saved offset when parsing LRC for that track ID.
- UI respects glass design (blurred container, neon accents).
- `flutter analyze` and `flutter test` succeed.

## Non-Goals
- No long-term persistence (no disk storage yet).
- No audio editing beyond offset.
- Spotify integration remains out of scope.

## Tasks
- [ ] Add LyricOffsetController (Riverpod) storing offsets per track.
- [ ] Update lyrics provider to apply saved offsets on parse and expose stream updates.
- [ ] Build LyricTrainer sheet with slider, live preview, save/reset buttons.
- [ ] Wire trainer button into Now Playing controls (glass button).
- [ ] Update tests / add tests for offset application.

## Risks / Notes
- Repeated re-parsing with offset must be efficient—consider caching.
- Ensure slider updates do not stutter while audio plays; may need debounce or direct ref update.
- Future work: persist offsets, karaoke mode with microphone.
