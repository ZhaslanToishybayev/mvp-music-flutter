# Advanced Search & Discovery — Spec

## Context
Current search is basic text-only. Users need better discovery tools with filters, visual genre chips, and improved search results presentation to find music they'll love.

## Goals
- Add search filters: genre, year, artist type, explicit content
- Implement visual genre chips with icons and colors
- Enhance search results with better metadata display
- Add search suggestions and recent searches
- Improve search performance with debouncing and caching

## Acceptance Criteria
- **Given** user opens search, **when** they see search bar, **then** filter chips appear below with genres (Rock, Pop, Hip-Hop, etc.)
- **Given** user taps genre chip, **when** they search, **then** results are filtered by that genre
- **Given** user types in search, **when** they pause typing for 300ms, **then** search executes automatically
- **Given** user searches "rock 2020", **when** results load, **then** only rock songs from 2020 appear
- **Given** user taps artist name, **when** they see artist page, **then** all tracks by that artist are listed
- **Given** user searches frequently, **when** they open search, **then** recent searches appear as suggestions
- **Given** user searches, **when** no results found, **then** helpful message with alternative suggestions appears
- **Given** user clears search, **when** they see empty state, **then** trending genres and popular artists are suggested
- All filters and chips follow glassmorphic design with consistent styling
- `flutter analyze` and `flutter test` pass

## Non-Goals
- AI-powered recommendations (separate feature)
- Search history persistence across app restarts
- Advanced filters like BPM, key, mood
- Integration with external music databases

## Tasks
- [ ] Create `SearchFilter` model with genre, year, artistType, explicit fields
- [ ] Add `SearchController` with debounced search and filter state
- [ ] Build `GenreChip` widget with icons and glass styling
- [ ] Create `SearchFiltersBar` with multiple filter chips
- [ ] Enhance `SearchResultsView` with better metadata and artist grouping
- [ ] Add `ArtistPage` for viewing all tracks by specific artist
- [ ] Implement search suggestions with recent searches
- [ ] Add empty state with trending suggestions
- [ ] Update iTunes API integration to support filter parameters
- [ ] Add search result caching for better performance
- [ ] Add tests for search filtering and UI interactions

## Technical Implementation
- **Filters**: Enum-based filter system with iTunes API parameter mapping
- **Debouncing**: 300ms delay to prevent excessive API calls
- **Caching**: In-memory cache for recent searches and results
- **UI**: Glass chips with hover effects, animated filter transitions
- **API**: Extend iTunes Search API calls with genre, year, explicit parameters
- **State**: Riverpod providers for search state, filters, suggestions

## Genre Mapping
- **Rock**: Alternative Rock, Classic Rock, Hard Rock, Indie Rock
- **Pop**: Pop, Dance Pop, Electropop, Teen Pop
- **Hip-Hop**: Hip-Hop, Rap, Trap, Alternative Hip-Hop
- **Electronic**: Electronic, EDM, House, Techno, Ambient
- **Jazz**: Jazz, Smooth Jazz, Bebop, Fusion
- **Classical**: Classical, Orchestral, Chamber Music
- **Country**: Country, Folk, Americana, Bluegrass
- **R&B**: R&B, Soul, Neo-Soul, Contemporary R&B

## Risks & Notes
- **API Limits**: iTunes Search API has rate limits; need intelligent caching
- **Genre Accuracy**: iTunes genres may not be perfectly accurate
- **Performance**: Multiple filters may slow down search results
- **UX**: Too many filters may overwhelm users; start with essential ones
- **Future**: Machine learning recommendations, mood-based search, social discovery

## Success Metrics
- Search completion rate: >90% (users finish typing and get results)
- Filter usage: >40% of searches use at least one filter
- Time to find music: <30 seconds average
- Search-to-play conversion: >60% of searches result in track playback
- User satisfaction: >4.5/5 rating for search experience

