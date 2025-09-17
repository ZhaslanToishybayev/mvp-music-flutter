# Favorites System — Spec

## Context
Users need a way to quickly save and access their favorite tracks without creating full playlists. A simple heart/favorites system provides immediate value and builds user engagement.

## Goals
- Add heart/favorite button to all track displays
- Create dedicated Favorites collection with easy access
- Persist favorites across app sessions
- Integrate favorites with existing queue and playback system
- Provide visual feedback for favorite status

## Acceptance Criteria
- **Given** user sees any track, **when** they tap heart icon, **then** track is added to favorites with visual feedback
- **Given** user taps heart on favorited track, **when** they see confirmation, **then** track is removed from favorites
- **Given** user opens Library, **when** they see "My Favorites" section, **then** all favorited tracks are displayed
- **Given** user has favorites, **when** they tap "Play All Favorites", **then** favorites load into queue and start playing
- **Given** user searches, **when** results show favorited tracks, **then** heart icons are filled/solid
- **Given** user adds track to favorites, **when** they see animation, **then** heart fills with smooth transition
- **Given** user removes from favorites, **when** they see animation, **then** heart empties with smooth transition
- **Given** user restarts app, **when** they open favorites, **then** all previously favorited tracks are still there
- All heart icons and favorites UI follow glassmorphic design system
- `flutter analyze` and `flutter test` pass

## Non-Goals
- Favorites sharing or social features
- Automatic favorites based on play count
- Favorites categories or tags
- Export favorites to external services

## Tasks
- [ ] Add `isFavorite` field to `Track` model
- [ ] Create `FavoritesRepository` with add/remove/get operations using SharedPreferences
- [ ] Add `FavoritesController` (Riverpod) for state management
- [ ] Create `FavoriteButton` widget with animated heart icon
- [ ] Add favorites section to Library screen with glass cards
- [ ] Update all track displays to include favorite button
- [ ] Add "Play All Favorites" action to favorites section
- [ ] Implement smooth heart fill/empty animations
- [ ] Add favorites count badge to Library navigation
- [ ] Update search results to show favorite status
- [ ] Add tests for favorites CRUD operations and UI interactions

## Technical Implementation
- **Storage**: Track IDs stored as Set<String> in SharedPreferences
- **State**: Riverpod providers for favorites set, add/remove operations
- **UI**: Animated heart icon with scale and color transitions
- **Integration**: Extend existing track displays with favorite button
- **Performance**: In-memory Set for fast lookup, lazy loading for large collections

## Visual Design
- **Heart Icon**: Outline when not favorited, filled when favorited
- **Colors**: Accent colors from design tokens (pink/red gradient)
- **Animation**: Scale from 0.8 to 1.2 with color transition (200ms)
- **Layout**: Heart positioned consistently across all track cards
- **Feedback**: Subtle haptic feedback on mobile devices

## Risks & Notes
- **Performance**: Large favorites collections may need pagination
- **Data Loss**: Need backup mechanism for favorites data
- **UX**: Heart icon should be clearly visible but not overwhelming
- **Consistency**: Favorite status must be consistent across all views
- **Future**: Smart favorites based on listening patterns, favorites playlists

## Success Metrics
- Favorites adoption: >80% of users favorite at least one track
- Average favorites per user: 15-25 tracks
- Favorites usage: >50% of users access favorites section weekly
- Heart interaction rate: >60% of track views result in heart tap
- User retention: +15% increase in weekly active users

## Implementation Priority
1. **Core Favorites**: Add/remove functionality with persistence
2. **UI Integration**: Heart buttons on all track displays
3. **Favorites Collection**: Dedicated section in Library
4. **Animations**: Smooth heart fill/empty transitions
5. **Advanced Features**: Play all favorites, search integration

