import 'package:flutter/material.dart';

IconData getIconForSubject(String subject) {
  final lowercase = subject.toLowerCase();
  if (lowercase.contains('math')) return Icons.calculate;
  if (lowercase.contains('science')) return Icons.science;
  if (lowercase.contains('history')) return Icons.menu_book;
  if (lowercase.contains('english')) return Icons.language;
  if (lowercase.contains('coding') || lowercase.contains('programming')) return Icons.code;
  if (lowercase.contains('art')) return Icons.brush;
  return Icons.school;
}
