# Audio Visualizer & Docs Polish — Spec

## Context
Lyric trainer is complete and offsets persist locally. Next step is to add a signature glassmorphic audio visualizer to Now Playing and tidy documentation/screenshots to reflect the new UX.

## Goals
- Add a lightweight real-time visualizer that matches the liquid-glass aesthetic.
- Ensure the visualizer performs well with 30-second previews and also hides gracefully on unsupported platforms.
- Refresh documentation/screenshots so portfolio reviewers immediately see the upgraded experience.

## Acceptance Criteria
- Now Playing shows an animated visualizer (bars or waves) beneath the artwork/controls when audio is playing.
- Visualizer responds to audio amplitude/levels (approximate via waveform/FFT or simulated using audio data) and pauses when playback stops.
- Visualizer runs efficiently (no jank) and disables itself on unsupported platforms (e.g., fallback message).
- README includes updated screenshots/gifs and a note about the lyric trainer + visualizer features.
- `flutter analyze` / `flutter test` succeed.

## Non-Goals
- No microphone-based karaoke yet.
- No cross-platform FFT accuracy guarantee; a simulated amplitude visualizer is acceptable as long as it looks dynamic.

## Tasks
- [ ] Add visualizer widget (e.g., glass bar/wave) driven by audio level stream or simulated peaks.
- [ ] Integrate visualizer into Now Playing layout with ambient styling and pause/resume states.
- [ ] Optimize performance (consider throttling, animations).
- [ ] Update README/assets with new screenshots and feature description.
- [ ] Run analyzer/tests.

## Risks / Notes
- just_audio on web may not expose raw samples; consider pseudo-random peaks with deterministic seed from track ID if necessary.
- Keep blur/animation balance to avoid overtaxing devices.
- Document fallback behavior if visualizer is unavailable.
