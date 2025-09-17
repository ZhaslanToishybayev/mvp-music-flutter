# MVP Player & Lyrics Sync — Spec

## Context
Flutter MVP музыкальный плеер с поиском по iTunes и воспроизведением 30–60s превью. Синхронные лирики (LRCLIB), тёмная тема, без аккаунтов/бэкенда.

## Story
As a listener, I want to search songs and play short previews with synced lyrics so I can discover music quickly.

## Scope
- Search (iTunes Search API, `country=US`, `limit=25`).
- Playback previews (just_audio + audio_session + just_audio_background).
- Now Playing: play/pause/seek, progress, next/prev, queue.
- Synced lyrics: parse LRC, highlight current line, smooth auto-scroll; tap line → seek.
- Dark theme by default. Web/Windows первично; Android/iOS — базовый ран + background controls.

## Data Sources
- Tracks: `GET https://itunes.apple.com/search?term={q}&media=music&limit=25&country=US`
- Lyrics: LRCLIB `GET /api/search` → `GET /api/get/{id}` → `syncedLyrics` (LRC).

## Defaults & Rules
- If `previewUrl` missing: показывать в выдаче, но кнопка Play disabled; в очередь не добавлять.
- Debounce поиска: 400ms; простое кеширование в памяти по `(q,country)` и `(track,artist,duration)`.
- Platforms: Android minSdk 23; iOS 13.0; Flutter channel stable.

## Acceptance Criteria
- Поиск по строке q: список ≤25 треков с обложкой, названием, артистом, длительностью.
- Тап Play на треке с `previewUrl` запускает аудио; Play/Pause/Seek работают; прогресс обновляется ≤200ms.
- Now Playing показывает обложку/метаданные/таймлайн; next/prev по очереди.
- Лирики LRC подсвечивают активную строку и плавно автоскроллятся; тап по строке делает seek к таймкоду.
- Если лирик нет: текст «No synced lyrics available» + кнопка «Повторить поиск».
- Background: уведомление/lock‑screen (title/artist/artwork); управление play/pause/next/prev функционирует.
- Тёмная тема включена по умолчанию.

## Non‑Goals
- Аккаунты/плейлисты, оффлайн‑загрузка, собственный бэкенд.

## Risks / Notes
- Ограничения iTunes/LRCLIB; нестабильность превью. Обработать ошибки и тайм‑ауты дружелюбно.
- Версии пакетов могут ограничивать minSdk/target — подбираем совместимые.

## Tasks (Checklist)
- [ ] Проект/зависимости (hooks_riverpod, go_router, dio, cached_network_image, intl, just_audio*, flutter_lyric).
- [ ] iTunes API client + кэш; экран поиска (UI + debounce).
- [ ] Audio service: play/pause/seek/queue + background metadata.
- [ ] LRCLIB client + LRC parser (fallback if нужно); lyrics view + scroll/seek.
- [ ] Now Playing UI + интеграция очереди.
- [ ] Темизация (dark), иконки/арт.
- [ ] Тесты: LRC parse; active line calc; базовый виджет lyrics_view.
- [ ] README + CI (analyze/test).
