// lib/data/repositories/study_session_repository_impl.dart

import 'package:smart_pace/src/features/screens/schedule/repository/study_session_repository.dart';

import '../models/study_session_entity.dart';
import '../models/study_session_hive_model.dart';
import '../models/study_session_local_datasource.dart';

class StudySessionRepositoryImpl implements StudySessionRepository {
  final StudySessionLocalDataSource _localDataSource;

  StudySessionRepositoryImpl(this._localDataSource);

  @override
  Future<List<StudySessionEntity>> getSessions() async {
    final models = await _localDataSource.getSessions();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> addSession(StudySessionEntity session) async {
    final model = StudySessionHiveModel.fromEntity(session);
    await _localDataSource.addSession(model);
  }

  @override
  Future<void> updateSession(StudySessionEntity session) async {
    final model = StudySessionHiveModel.fromEntity(session);
    await _localDataSource.updateSession(model);
  }

  @override
  Future<void> deleteSession(String id) async {
    await _localDataSource.deleteSession(id);
  }
}