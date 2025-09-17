# Performance Polish — Spec

## Context
Glass UI + animations + visualizer can stress devices. We want consistently smooth UX on mid-range hardware.

## Goals
- 60fps target on desktop/mobile during common flows (search, scroll, play)
- Visualizer/blur throttling on low-power devices
- Fast startup time and reduced GC churn

## Acceptance Criteria
- Given Now Playing is visible, when visualizer animates, then no visible jank during playback on desktop
- Given Library list scrolls, when 25 items are shown, then frame budget is met (no long frames)
- Startup time < 2s on desktop (cold)
- `flutter analyze`/`flutter test` pass

## Tasks
- [ ] Profile with `flutter run --profile` and `flutter devtools`
- [ ] Reduce rebuilds in hot paths (selectors, const widgets)
- [ ] Throttle/disable heavy effects under load (blur sigma caps)
- [ ] Memoize/cached images, tune CachedNetworkImage options
- [ ] Tune visualizer update interval based on device category
- [ ] Add lightweight perf log toggles (debug only)

## Risks
- Over-throttling may degrade visual quality
- Device variability complicates targets
