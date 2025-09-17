# Lyric Trainer Polish v2 — Spec

## Context
Lyric sync trainer works for the session, but offsets reset after app reload. Also, UI polish improvements are still needed (animations, empty-state glass, visual finesse) for a premium experience.

## Goals
- Persist lyric offsets per track using local storage and reuse them when re-launching the app.
- Improve lyric trainer UX: display the current offset label dynamically, animate the slider thumb, offer live preview cues.
- Polish UI details around Library/Now Playing (e.g., animations, spacing, empty states) to remove remaining rough edges.

## Acceptance Criteria
- Offset editing via Lyric Trainer stores values using `shared_preferences` keyed by track ID, loaded at startup.
- On app launch, previously saved offsets are applied automatically in `lyrics_provider`.
- Trainer sheet shows dynamic offset label, smooth slider animations, and ensures the lyric list scrolls with the new offset.
- Library/Now Playing visually align with liquid-glass style (adjusted paddings/hero/mini player transitions) and no overflow warnings remain.
- `flutter analyze` / `flutter test` pass.

## Non-Goals
- No support for multiple user profiles or cloud sync yet.
- No microphone recording/karaoke mode yet.

## Tasks
- [ ] Add `shared_preferences` dependency and create LyricOffsetRepository for load/save/delete per track.
- [ ] Update LyricOffsetController to bootstrap from repository and persist on changes (with tests).
- [ ] Tweak Lyric Trainer UI: offset label, slider animation, ensure lyrics reflect offset instantly.
- [ ] Adjust Library/Now Playing layouts (padding, animations, bottom stack) to clean up visual glitches.
- [ ] Run analyzer/tests and update screenshots/docs if needed.

## Risks / Notes
- Shared prefs calls must be awaited/guarded to avoid UI jank; consider caching in memory after load.
- Ensure slider updates don't cause rebuild loops; may need debounce or separate notifier for smooth updates.
- Keep glass effects performant (avoid excessive blur redraws).
