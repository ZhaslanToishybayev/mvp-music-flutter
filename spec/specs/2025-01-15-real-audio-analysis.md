# Real Audio Analysis & FFT Visualizer — Spec

## Context
Current visualizer uses simulated waveforms. Real audio analysis with FFT (Fast Fourier Transform) would provide authentic visualization that responds to actual audio frequencies and amplitudes.

## Goals
- Replace simulated visualizer with real-time FFT analysis
- Provide multiple visualization modes (bars, waves, spectrum)
- Ensure cross-platform compatibility (desktop/mobile/web)
- Maintain performance with smooth 60fps animations
- Add visualizer settings and customization options

## Acceptance Criteria
- **Given** audio is playing, **when** visualizer is active, **then** bars respond to actual audio frequencies
- **Given** user changes song, **when** new track plays, **then** visualizer adapts to new audio characteristics
- **Given** user pauses audio, **when** visualizer updates, **then** bars smoothly fade to baseline
- **Given** user is on desktop, **when** they see visualizer, **then** FFT analysis works with real audio data
- **Given** user is on mobile, **when** they see visualizer, **then** FFT analysis works with real audio data
- **Given** user is on web, **when** they see visualizer, **then** fallback message shows (FFT not supported)
- **Given** user opens visualizer settings, **when** they change mode, **then** visualization style updates immediately
- **Given** user adjusts sensitivity, **when** they see visualizer, **then** bar heights respond to new sensitivity
- All visualizer modes follow glassmorphic design with consistent styling
- `flutter analyze` and `flutter test` pass

## Non-Goals
- Microphone input analysis (karaoke mode)
- Audio recording or processing
- Real-time audio effects or filters
- Integration with external audio analysis libraries

## Tasks
- [ ] Research FFT libraries: `fft` package vs `dart:ffi` with native libraries
- [ ] Create `AudioAnalyzer` service with FFT implementation
- [ ] Add `VisualizerMode` enum (bars, waves, spectrum, circle)
- [ ] Create `FFTVisualizer` widget with real-time analysis
- [ ] Add `VisualizerSettings` with sensitivity, mode, color options
- [ ] Implement platform-specific audio data access
- [ ] Add fallback for unsupported platforms (web)
- [ ] Create multiple visualization renderers (CustomPainter)
- [ ] Add visualizer settings panel in Now Playing
- [ ] Optimize performance with efficient FFT calculations
- [ ] Add tests for FFT analysis and visualizer rendering

## Technical Implementation
- **FFT Library**: `fft` package for Dart, or `dart:ffi` with native FFT libraries
- **Audio Data**: Access raw audio samples from `just_audio` or platform audio APIs
- **Performance**: FFT calculations on separate isolate, 60fps rendering
- **Platform Support**: 
  - Desktop: Direct audio buffer access
  - Mobile: Platform audio analysis APIs
  - Web: Fallback to simulated visualization
- **UI**: Multiple CustomPainter implementations for different modes

## Visualization Modes
1. **Frequency Bars**: Traditional equalizer-style bars (current implementation)
2. **Waveform**: Smooth wave visualization with amplitude
3. **Spectrum**: Circular spectrum with frequency distribution
4. **Particle**: Floating particles that respond to audio
5. **Minimal**: Simple line graph with subtle animation

## Platform Considerations
- **Desktop**: Full FFT support with real audio buffers
- **Mobile**: Platform-specific audio analysis (Android AudioRecord, iOS AVAudioEngine)
- **Web**: Limited by browser security; fallback to simulated visualization
- **Performance**: FFT calculations may impact battery life on mobile

## Risks & Notes
- **Performance**: FFT calculations are CPU-intensive; need optimization
- **Platform Differences**: Audio access varies significantly across platforms
- **Battery Impact**: Continuous FFT analysis may drain battery on mobile
- **Complexity**: Real audio analysis is significantly more complex than simulation
- **Future**: Audio effects, real-time audio processing, microphone input

## Success Metrics
- Visualizer responsiveness: <16ms frame time for 60fps
- CPU usage: <10% additional CPU usage for FFT analysis
- Battery impact: <5% additional battery drain per hour
- User satisfaction: >4.0/5 rating for visualizer quality
- Platform compatibility: Works on 95% of target devices

## Implementation Phases
1. **Research & Prototype**: Test FFT libraries and audio data access
2. **Core FFT**: Implement basic FFT analysis with frequency bars
3. **Platform Support**: Add desktop and mobile audio data access
4. **Multiple Modes**: Implement different visualization styles
5. **Settings & Polish**: Add customization options and performance optimization

