import 'dart:ui';

class Task {
  final String title;
  final int points;
  final String status;
  final String timeLeft;
  final Color statusColor;
  final bool isHighlighted;
  final String progress;

  Task({
    required this.title,
    required this.points,
    required this.status,
    required this.timeLeft,
    required this.statusColor,
    required this.isHighlighted,
    required this.progress,
  });
}
