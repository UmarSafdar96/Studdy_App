// lib/domain/repositories/study_session_repository.dart

import '../models/study_session_entity.dart';

abstract class StudySessionRepository {
  Future<List<StudySessionEntity>> getSessions();
  Future<void> addSession(StudySessionEntity session);
  Future<void> updateSession(StudySessionEntity session);
  Future<void> deleteSession(String id);
}