# Playlist Management — Spec

## Context
Users can search and play individual tracks, but there's no way to save collections or organize music. Playlist management is the most natural next feature that builds on our existing queue system and enhances user retention.

## Goals
- Enable users to create, name, and save custom playlists
- Allow adding/removing tracks from playlists with drag-and-drop
- Provide playlist browsing, editing, and deletion
- Integrate seamlessly with existing queue and playback system

## Acceptance Criteria
- **Given** user is on Library screen, **when** they tap "Create Playlist", **then** modal opens with name input and track selection
- **Given** user has tracks in queue, **when** they tap "Save as Playlist", **then** modal opens with queue tracks pre-selected
- **Given** user is viewing a playlist, **when** they tap "Play All", **then** playlist loads into queue and starts playing
- **Given** user is in playlist editor, **when** they drag track to reorder, **then** order updates immediately with smooth animation
- **Given** user taps track in playlist, **when** they swipe left, **then** "Remove" option appears with confirmation
- **Given** user has playlists, **when** they open Library, **then** "My Playlists" section shows with glass cards
- **Given** user deletes playlist, **when** confirmation dialog appears, **then** playlist is permanently removed
- All UI follows glassmorphic design system with consistent styling
- `flutter analyze` and `flutter test` pass

## Non-Goals
- Playlist sharing or collaboration features
- Import/export playlists from other services
- Playlist folders or categories
- Automatic playlist generation based on listening history

## Tasks
- [ ] Create `Playlist` model with id, name, tracks, createdAt, updatedAt
- [ ] Add `PlaylistRepository` with CRUD operations using SharedPreferences
- [ ] Create `PlaylistController` (Riverpod) for state management
- [ ] Build `CreatePlaylistSheet` with name input and track selection
- [ ] Build `PlaylistEditorScreen` with drag-to-reorder and remove actions
- [ ] Add "My Playlists" section to Library screen with glass cards
- [ ] Integrate "Save as Playlist" button in queue view
- [ ] Add playlist actions to track context menus
- [ ] Update queue system to handle playlist loading
- [ ] Add tests for playlist CRUD operations and UI interactions

## Technical Implementation
- **Storage**: JSON serialization in SharedPreferences (simple, no SQLite needed)
- **State**: Riverpod providers for playlist list, current playlist, CRUD operations
- **UI**: Glass containers, drag-and-drop with `ReorderableListView`
- **Navigation**: Modal sheets for creation/editing, full screen for playlist view
- **Integration**: Extend existing queue system to support playlist loading

## Risks & Notes
- **Performance**: Large playlists (>100 tracks) may need pagination
- **Data Loss**: Need backup/restore mechanism for playlist data
- **UX**: Drag-and-drop on mobile needs careful touch handling
- **Storage**: SharedPreferences has size limits; consider migration to SQLite for large collections
- **Future**: Playlist sharing, collaborative editing, smart playlists

## Success Metrics
- >70% of users create at least one playlist within first week
- Average playlist size: 8-15 tracks
- Playlist creation completion rate: >85%
- User retention: +25% increase in daily active users

