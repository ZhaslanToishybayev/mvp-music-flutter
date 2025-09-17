class LyricsLine {
  final int timestampMs;
  final String text;

  const LyricsLine({
    required this.timestampMs,
    required this.text,
  });

  factory LyricsLine.fromLrc(String lrcLine) {
    final regex = RegExp(r'\[(\d{2}):(\d{2})\.(\d{2,3})\]');
    final match = regex.firstMatch(lrcLine);
    
    if (match != null) {
      final minutes = int.parse(match.group(1)!);
      final seconds = int.parse(match.group(2)!);
      final milliseconds = int.parse(match.group(3)!);
      final timestampMs = (minutes * 60 + seconds) * 1000 + milliseconds;
      final text = lrcLine.substring(match.end);
      return LyricsLine(timestampMs: timestampMs, text: text);
    }
    
    return LyricsLine(timestampMs: 0, text: lrcLine);
  }
}
