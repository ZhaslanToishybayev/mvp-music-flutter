# Release Hardening: Web + Linux — Spec

## Context
Web dev-server works but needs UX polish (autoplay, device selection, ports). Linux run hits `MissingPluginException` for `just_audio`. We want a reliable demo on Web and Linux with clear guidance.

## Goals
- Web: stable run using Chrome device when available; fallback to web-server with clear limits.
- Web: consistent port handling and autoplay UX (tap-to-play banner).
- Linux: fix `just_audio` platform implementation and ensure playback works.
- Docs: actionable run instructions and troubleshooting.

## Acceptance Criteria
- Given a machine with Chrome, when running `flutter run -d chrome`, the app launches and plays previews after a tap; visualizer animates (simulated on web).
- Given Chrome is not available, when running `flutter run -d web-server`, the app serves on a free port and shows an autoplay tip; no startup errors.
- Given Linux desktop, when running `flutter run -d linux`, playback works without `MissingPluginException` and controls function.
- README updated with clear Web/Linux run commands and notes.
- `flutter analyze` / `flutter test` pass.

## Non-Goals
- Real FFT for Web (separate spec).
- Background audio on Web.

## Tasks
- [ ] Linux: add `just_audio_linux` (or platform impl required by current `just_audio`) to `pubspec.yaml`, fetch packages, verify plugin registration.
- [ ] Add a helper script target to detect Chrome and choose `-d chrome` or `-d web-server` with a free port.
- [ ] Ensure visualizer hybrid mode stays enabled on Web (simulated) and mobile/desktop full.
- [ ] Improve error mapping for Web (autoplay/missing preview) — already added; validate.
- [ ] Docs: update README with Web run options, port tips, and Chrome/extension guidance.
- [ ] Manual QA: run Web (Chrome and web-server) + Linux end-to-end (search, play, visualizer, lyrics, queue, playlists, favorites).

## Risks / Notes
- `just_audio` platform support varies by version; verify compatible `just_audio_linux` version.
- Some Linux distros may require additional GStreamer codecs; ensure setup script covers deps.


