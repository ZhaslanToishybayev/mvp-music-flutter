# Release QA Checklist — Spec

## Context
Before showcasing/ship, we want a deterministic QA pass across platforms.

## Device Matrix
- Desktop: Linux (Ubuntu), Windows 11
- Mobile: Android emulator (API 34), physical Android if available
- Web: Chrome latest (web-server), optional Edge

## Test Scenarios
- Search: type and chips, results appear, empty state
- Playback: play/pause/seek, next/prev, queue add/remove/clear
- Visualizer: visible while playing; settings sheet opens; wave/bars OK
- Lyrics: load success, tap-to-seek, trainer open/save/reset
- Playlists: create/save queue, open editor, reorder, delete
- Favorites: heart/unheart in list and queue; My Favorites row updates
- Advanced Search: genre/year/explicit filters; recent searches tap-to-run
- Web: autoplay gating; message when disabled

## Pass Criteria
- No crashes; no visible jank; user-facing errors are clear
- Features behave as per specs; screenshots captured
- Analyzer/tests OK

## Artifacts
- Screenshots/GIFs added to docs/media
- Build artifacts: Linux bundle, Web build

## Risks
- Browser/device variance; adjust guidance in README
