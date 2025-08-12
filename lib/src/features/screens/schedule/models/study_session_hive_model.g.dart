// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_session_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudySessionHiveModelAdapter extends TypeAdapter<StudySessionHiveModel> {
  @override
  final int typeId = 0;

  @override
  StudySessionHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudySessionHiveModel(
      id: fields[0] as String,
      title: fields[1] as String,
      subject: fields[2] as String,
      startTime: fields[3] as String,
      endTime: fields[4] as String,
      colorValue: fields[5] as int,
      type: fields[6] as String,
      sessionDate: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, StudySessionHiveModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.subject)
      ..writeByte(3)
      ..write(obj.startTime)
      ..writeByte(4)
      ..write(obj.endTime)
      ..writeByte(5)
      ..write(obj.colorValue)
      ..writeByte(6)
      ..write(obj.type)
      ..writeByte(7)
      ..write(obj.sessionDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudySessionHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
