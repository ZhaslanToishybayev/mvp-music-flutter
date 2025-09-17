# Next Phase Roadmap — Spec

## Context
Audio visualizer and lyric trainer are complete. The MVP music app now has core functionality: iTunes search, playback, synced lyrics, glassmorphic UI, and audio visualization. Time to plan the next development phase.

## Current Status ✅
- **Core MVP**: iTunes search, 30s previews, play/pause/seek, queue management
- **Lyrics**: LRCLIB integration, sync highlighting, tap-to-seek
- **UI**: Liquid glass design system, ambient backgrounds, glass controls
- **Audio Visualizer**: Real-time bars with glassmorphic styling (desktop/mobile)
- **Lyric Trainer**: Offset adjustment with persistent storage
- **Quality**: All tests pass, analyzer clean, documentation updated

## Next Phase Priorities

### Phase 1: Enhanced User Experience (2-3 weeks)
1. **Playlist Management** - Create, save, and manage custom playlists
2. **Advanced Search** - Filters by genre, year, artist with visual chips
3. **Favorites System** - Heart tracks, view favorites collection
4. **Improved Queue** - Drag-to-reorder, clear queue, shuffle mode

### Phase 2: Audio Features (2-3 weeks)
1. **Real Audio Analysis** - FFT-based visualizer instead of simulated
2. **Equalizer** - Basic EQ with presets (Rock, Pop, Classical, etc.)
3. **Crossfade** - Smooth transitions between tracks
4. **Audio Effects** - Reverb, echo, pitch adjustment

### Phase 3: Social & Sharing (2-3 weeks)
1. **Share Tracks** - Share previews with friends via links
2. **Playlist Sharing** - Export/import playlists as JSON
3. **Social Features** - "Now Playing" status, activity feed
4. **Collaborative Playlists** - Multiple users editing same playlist

### Phase 4: Advanced Features (3-4 weeks)
1. **Karaoke Mode** - Microphone input with pitch detection
2. **Music Discovery** - AI recommendations based on listening history
3. **Offline Mode** - Cache previews for offline listening
4. **Multi-platform Sync** - Sync playlists across devices

## Immediate Next Steps
1. **Playlist Management** - Most requested feature, builds on existing queue system
2. **Advanced Search** - Enhances discovery experience
3. **Favorites System** - Simple but valuable user retention feature

## Success Metrics
- User engagement: Average session time > 5 minutes
- Feature adoption: >60% users create at least one playlist
- Performance: App startup < 2 seconds, smooth 60fps animations
- Quality: Maintain 100% test coverage, zero analyzer warnings

## Risks & Considerations
- **API Limits**: iTunes Search API has rate limits, need caching strategy
- **Performance**: Advanced features may impact older devices
- **Platform Differences**: Some features may not work on web
- **User Data**: Need privacy policy for any data collection

## Non-Goals (Out of Scope)
- Full music streaming (Spotify/Apple Music integration)
- User accounts and authentication
- Payment processing
- Real-time collaboration features
- Mobile app store distribution

