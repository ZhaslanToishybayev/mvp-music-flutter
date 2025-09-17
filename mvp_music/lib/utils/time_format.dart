String mmSsFromMs(int? milliseconds) {
  if (milliseconds == null) return '0:00';
  
  final totalSeconds = milliseconds ~/ 1000;
  final minutes = totalSeconds ~/ 60;
  final seconds = totalSeconds % 60;
  
  return '$minutes:${seconds.toString().padLeft(2, '0')}';
}

String mmSsFromDuration(Duration duration) {
  final minutes = duration.inMinutes;
  final seconds = duration.inSeconds % 60;
  
  return '$minutes:${seconds.toString().padLeft(2, '0')}';
}
