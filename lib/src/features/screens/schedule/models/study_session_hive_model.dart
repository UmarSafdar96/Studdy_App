// lib/data/models/study_session_hive_model.dart
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:smart_pace/src/features/screens/schedule/models/study_session_entity.dart';

part 'study_session_hive_model.g.dart'; // This will be generated


@HiveType(typeId: 0)
class StudySessionHiveModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String subject;

  @HiveField(3)
  String startTime;

  @HiveField(4)
  String endTime;

  @HiveField(5)
  int colorValue; // Store color as int

  @HiveField(6)
  String type;

  @HiveField(7) // <--- NEW HIVE FIELD INDEX
  DateTime sessionDate; // <--- ADDED THIS FIELD

  StudySessionHiveModel({
    required this.id,
    required this.title,
    required this.subject,
    required this.startTime,
    required this.endTime,
    required this.colorValue,
    required this.type,
    required this.sessionDate, // <--- ADDED TO CONSTRUCTOR
  });

  // Factory constructor to convert from StudySessionEntity
  factory StudySessionHiveModel.fromEntity(StudySessionEntity entity) {
    return StudySessionHiveModel(
      id: entity.id,
      title: entity.title,
      subject: entity.subject,
      startTime: entity.startTime,
      endTime: entity.endTime,
      colorValue: entity.color.value,
      type: entity.type,
      sessionDate: entity.sessionDate, // <--- ADDED CONVERSION
    );
  }

  // Method to convert to StudySessionEntity
  StudySessionEntity toEntity() {
    return StudySessionEntity(
      id: id,
      title: title,
      subject: subject,
      startTime: startTime,
      endTime: endTime,
      color: Color(colorValue),
      type: type,
      sessionDate: sessionDate, // <--- ADDED CONVERSION
    );
  }
}