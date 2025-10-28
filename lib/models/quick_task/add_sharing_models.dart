import 'package:flutter/material.dart';

class Task {
  final int id;
  final IconData icon;
  final String title;
  final String description;
  final int credits;
  final String buttonText;
  bool isCompleted;

  Task({
    required this.id,
    required this.icon,
    required this.title,
    required this.description,
    required this.credits,
    required this.buttonText,
    required this.isCompleted,
  });
}
