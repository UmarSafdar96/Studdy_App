// lib/data/datasources/local/study_session_local_datasource.dart
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_pace/src/features/screens/schedule/models/study_session_hive_model.dart';

abstract class StudySessionLocalDataSource {
  Future<List<StudySessionHiveModel>> getSessions();
  Future<void> addSession(StudySessionHiveModel session);
  Future<void> updateSession(StudySessionHiveModel session);
  Future<void> deleteSession(String id);
}

class StudySessionLocalDataSourceImpl implements StudySessionLocalDataSource {
  final Box<StudySessionHiveModel> _sessionBox;

  StudySessionLocalDataSourceImpl(this._sessionBox);

  @override
  Future<List<StudySessionHiveModel>> getSessions() async {
    return _sessionBox.values.toList();
  }

  @override
  Future<void> addSession(StudySessionHiveModel session) async {
    await _sessionBox.put(session.id, session);
  }

  @override
  Future<void> updateSession(StudySessionHiveModel session) async {
    await _sessionBox.put(session.id, session);
  }

  @override
  Future<void> deleteSession(String id) async {
    await _sessionBox.delete(id);
  }
}