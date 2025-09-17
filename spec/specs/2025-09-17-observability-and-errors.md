# Observability & Error Handling — Spec

## Context
We need clearer error surfacing (web autoplay, missing preview, network) and optional crash/error reporting hooks for production.

## Goals
- Centralized error mapping with user-friendly messages
- Non-intrusive logging in debug; quiet in release
- Optional Sentry/Crashlytics integration behind a flag

## Acceptance Criteria
- Given playback fails, when error occurs, then a human-friendly toast/banner shows and logs a concise debug line
- Given lyrics fetch fails, when retry is available, then user sees a retry action and error reason
- `flutter analyze`/`flutter test` pass

## Tasks
- [ ] Add error mapper/util (network, platform, autoplay)
- [ ] Add scoped debug logger (prints in debug only)
- [ ] Wire toast/snackbar for playback/lyrics errors
- [ ] Optional: add Sentry DSN config (compile-time env) with minimal breadcrumbs

## Risks
- Over-logging may hurt performance; ensure debug-only verbosity
