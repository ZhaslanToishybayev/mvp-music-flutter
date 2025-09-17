# Liquid Glass UX Polish — Spec

## Context
The initial liquid-glass refresh is in place, but we want the music discovery and now playing experience to feel like a premium glassmorphic app with curated content, ambient visuals, and consistent glass controls.

## Goals
- Elevate the Library (Discover) screen with a hero highlight, curated mood chips, glass search and list styling, plus a persistent glass nav/mini-player stack.
- Enhance Now Playing with ambient artwork, refined controls, refreshed progress bar, and aligned lyrics/queue styling.
- Provide reusable glass widgets/tokens for consistency.

## Acceptance Criteria
- Library screen shows (Given results fetched): hero card with play action, horizontal curated chips, glass search bar, glass track cards, and glass bottom nav stacked with mini-player.
- Empty state displays glass panel with CTA text instead of blank page.
- Now Playing shows blurred ambient background, glass section for controls, updated TabBar styling, and lyrics view with highlighted active line.
- Shared widgets (`GlassContainer`, `GlassIconButton`, `GlassChip`, `GlassNavBar`) provide consistent gradients/borders/shadows.
- Theme tokens (colors, spacing, durations) available via `design_tokens.dart` and used across UI.
- `flutter analyze` and `flutter test` pass.

## Non-Goals
- No backend or player logic changes beyond styling.
- No Spotify integration yet.

## Tasks
- [x] Add design tokens + glass widgets (container/icon/chip/nav).
- [x] Rebuild Library screen (hero, chips, search card, animated list, nav/mini-player stack).
- [x] Update Now Playing (ambient background, glass controls, progress bar, TabBar).
- [x] Refresh lyrics/queue styling and empty states.
- [x] Verify analyzer/tests pass.

## Risks / Notes
- Glass blurs can impact performance on older devices; monitor if future profiling needed.
- Future work: animations (hero transitions, audio visualizer), demo track for karaoke, Spotify integration.
