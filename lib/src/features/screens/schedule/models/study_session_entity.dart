// lib/domain/entities/study_session_entity.dart
import 'package:flutter/material.dart';


class StudySessionEntity {
  final String id;
  final String title;
  final String subject;
  final String startTime;
  final String endTime;
  final Color color;
  final String type;
  final DateTime sessionDate; // <--- ADDED THIS FIELD

  StudySessionEntity({
    required this.id,
    required this.title,
    required this.subject,
    required this.startTime,
    required this.endTime,
    required this.color,
    required this.type,
    required this.sessionDate, // <--- ADDED TO CONSTRUCTOR
  });

  StudySessionEntity copyWith({
    String? id,
    String? title,
    String? subject,
    String? startTime,
    String? endTime,
    Color? color,
    String? type,
    DateTime? sessionDate, // <--- ADDED TO copyWith
  }) {
    return StudySessionEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      subject: subject ?? this.subject,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      color: color ?? this.color,
      type: type ?? this.type,
      sessionDate: sessionDate ?? this.sessionDate, // <--- ADDED TO copyWith
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is StudySessionEntity &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              title == other.title &&
              subject == other.subject &&
              startTime == other.startTime &&
              endTime == other.endTime &&
              color == other.color &&
              type == other.type &&
              sessionDate == other.sessionDate;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      subject.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      color.hashCode ^
      type.hashCode ^
      sessionDate.hashCode;
}