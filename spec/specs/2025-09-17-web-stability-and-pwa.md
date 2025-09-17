# Web Stability & PWA — Spec

## Context
Web build runs via web-server but the UX feels flaky (autoplay, focus, debug extension requirement, potential CORS). We want a crisp web experience or a graceful statement of limitations.

## Goals
- Reliable playback start on user gesture; clear handling of autoplay restrictions
- Correct error messages when audio fails (no preview, blocked by browser)
- Optional PWA config (manifest/service worker) for better installability
- Document web limitations and recommended desktop/mobile paths

## Acceptance Criteria
- Given the app is opened on the web, when user clicks Play, then preview starts or a visible error toast appears with retry
- Given audio is blocked by autoplay policy, when user interacts (tap), then playback proceeds without page reload
- Given track lacks `previewUrl`, when user taps Play, then a clear disabled state shows (no silent failure)
- PWA manifest is valid and Lighthouse installable passes (if PWA enabled)
- README Troubleshooting updated for web (autoplay, debug extension)
- `flutter analyze` / `flutter test` succeed

## Non-Goals
- Full parity with desktop/mobile background audio
- Real FFT on web (documented as fallback)

## Tasks
- [ ] Add explicit user-gesture gating for `play()` on web
- [ ] Centralize playback error mapping for web-specific errors
- [ ] Update `web/manifest.json` with icons/name; consider simple service worker
- [ ] Add README web section with autoplay/extension guidance
- [ ] Add e2e smoke steps (manual) for web launch

## Risks
- Browser differences (Chrome/Edge/Firefox) may vary behavior
- PWA caching may introduce staleness; keep SW simple
