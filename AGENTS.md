# Repository Guidelines

This file is the working constitution for the repo. It defines how the agent builds. The spec folder is the source of truth for what to build.

## Project Structure & Sources of Truth
- Specs: `spec/` (author, review, then implement). Primary SoT.
- Code: created per specs (Flutter MVP app when requested).
- This file: how to build (process, rules, tech choices). Keep in sync with `spec/`.

## Build, Test, Dev (when Flutter app exists)
- Run: `flutter run -d windows | -d chrome | -d <android>`
- Tests: `flutter test`
- Analyze/format: `flutter analyze`, `dart format .`
- Builds: `flutter build windows | web | apk | appbundle`

## Coding Style
- Format with `dart format`; fix all analyzer warnings.
- Naming: files `snake_case.dart`; classes `UpperCamelCase`; variables/methods `lowerCamelCase`.
- Keep patches minimal and scoped to the task.

---

## Конституция репозитория для AI‑агента (Codex/Copilot)
Проект: Flutter MVP music app с синхронизированными лириками как в Spotify.

### 0) Режим работы
- Пользователь не пишет код вручную — весь цикл делает агент.
- Источник правды: `spec/` (Spec‑Kit). Сначала следуй AGENTS.md (это «как строим»), затем синхронизируй и обнови `spec/`.
- Агент может обновлять этот файл, если это повышает качество/надёжность.

### 1) Цели MVP
- Воспроизведение музыкальных превью (30–60 c) по результатам поиска.
- Экраны: Library/Search (поиск, список треков) и Now Playing (play/pause/seek, прогресс, next/prev, очередь, обложка, метаданные).
- Синхронизированные лирики: подсветка текущей строки + плавная автопрокрутка.
- Background playback + lock‑screen controls (Android, iOS).
- Тёмная тема по умолчанию. Нет логина и собственного бэкенда.

### 2) Технологии и версии
- Flutter: stable. Цели: Android (эмулятор/девайс), iOS (сборка и базовый ран).
- Плеер: `just_audio`, `just_audio_background`, `audio_session`.
- Лирики: `flutter_lyric` (если не хватит — fallback: свой LRC парсер/рендер).
- Состояние: `hooks_riverpod`; Навигация: `go_router`.
- HTTP: `dio` (предпочтительно) или `http`.
- Изображения: `cached_network_image`; кеш: `shared_preferences` или простой file cache.
- Утилиты: `intl`. Версии подбирает агент и фиксирует в `pubspec.lock`.

### 3) Источники данных
- Каталог музыки (поиск/метаданные/превью): iTunes Search API
  - `GET https://itunes.apple.com/search?term={q}&media=music&limit=25`
  - Поля: `trackName`, `artistName`, `artworkUrl100/600`, `previewUrl`, `trackTimeMillis`.
- Лирики (с таймкодами): LRCLIB
  - Шаг 1: `GET /api/search?track_name=&artist_name=&duration=`
  - Шаг 2: `GET /api/get/{id}` → `syncedLyrics` (LRC). Если нет — допускается plain lyrics, но цель — синхрония.

### 4) Структура проекта (когда создаём Flutter)
```
lib/
  main.dart
  app/router.dart
  theme/app_theme.dart
core/
  models/track.dart
  models/lyrics_line.dart
  utils/time_format.dart
data/
  sources/itunes_api.dart
  sources/lyrics_api.dart
  repositories/track_repository.dart
features/
  library/
    library_screen.dart
    search_controller.dart
  player/
    now_playing_screen.dart
    controllers/player_controller.dart
    services/audio_player_service.dart
    widgets/lyrics_view.dart
assets/ (может быть пусто)
```

### 5) UI/UX
- Тёмная тема; Library/Search: поиск + список (обложка, название, артист, длительность).
- Now Playing: крупная обложка, таймлайн (seekable), prev/play/pause/next, очередь, панель лирики.
- Лирики: выделение активной строки, плавная автопрокрутка; тап по строке — seek к таймкоду.

### 6) Поведение плеера
- Инициализировать `AudioSession` перед воспроизведением.
- `just_audio_background`: `MediaItem` (title, artist, artUri) для уведомлений/lock‑screen.
- Очередь: результаты поиска можно добавлять в Up Next.
- При смене трека — синхронизировать лирику, перепарсить LRC при новом `previewUrl`.

### 7) Лирики и синхронизация
- Модель: `LyricsLine(timestampMs, text)`; парсинг LRC.
- Синхронизация: подписка на позицию (`Stream<Duration>`), бинарный поиск активной строки.
- Анимация: `scrollToIndex` к активной строке с троттлингом; fallback «No synced lyrics available» с действиями.

### 8) Качество / тесты / lint
- `flutter analyze` — чисто. Форматирование `dart format`.
- Тесты (минимум):
  - Юнит: парсер LRC; вычисление активной строки по времени.
  - Виджет: рендер `lyrics_view` (golden — по возможности).
- Цель покрытия: ~60% для MVP. Падающие тесты/анализ — исправить до merge.

### 9) CI (минимум)
- `.github/workflows/ci.yml`: триггеры `push`/`pull_request`; шаги: `flutter pub get`, `flutter analyze`, `flutter test`.
- Агент поддерживает CI в зелёном состоянии.

### 10) Платформенные настройки
- Android: разрешения/foreground service для аудио и уведомлений (манифест).
- iOS: `UIBackgroundModes` → `audio`; корректная категория `AudioSession`.

### 11) Документация
- `README.md`: требования (Flutter), установка зависимостей, запуск, почему iTunes/LRCLIB и их ограничения, troubleshooting.

### 12) Процесс работы агента (цикл)
1) Синхронизация контекста: прочитать `AGENTS.md`, `spec/spec-kit.md`.
2) План: задачи чек‑листом (в PR или `docs/plan.md`).
3) Реализация: малыми шагами — структура, зависимости, `itunes_api`, `lyrics_api`, `audio_player_service`, экраны/виджеты, платформа, доки.
4) Качество: `flutter analyze` + тесты зелёные.
5) Финальный прогон: `flutter run` (эмулятор Android/Windows/Web) и статусы CI.
6) Отчёт: краткое резюме, что улучшить.
7) Если блокеры: предложить до 2–3 вариантов и выбрать лучший; при необходимости спросить пользователя.

### 13) Решения по умолчанию
- Тёмная тема; адаптивные лейауты для телефонов/малых планшетов.
- Лимит поиска: 25. Ответы iTunes/LRCLIB кешируются в памяти процесса.
- Логи: ненавязчивые (`debugPrint`), без спама в релизе. Никаких секретов в репозитории.

### 14) Запреты и ограничения
- Не менять зависимости/Flutter channel без явного запроса.
- Не коммитить ключи, токены, учётные данные, приватные пути.
- Не редактировать `android/` и `ios/`, если задача не про платформенный код.
- Не расширять скоп задач без обновления спецификации в `spec/`.

