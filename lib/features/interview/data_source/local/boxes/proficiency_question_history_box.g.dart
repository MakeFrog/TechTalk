// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proficiency_question_history_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProficiencyQuestionHistoryBoxAdapter
    extends TypeAdapter<ProficiencyQuestionHistoryBox> {
  @override
  final int typeId = 5;

  @override
  ProficiencyQuestionHistoryBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProficiencyQuestionHistoryBox(
      skillQuestionSet: (fields[0] as List)
          .map((dynamic e) => (e as Map).map((dynamic k, dynamic v) =>
              MapEntry(k as String, (v as List).cast<String>())))
          .toList(),
      jobGroupQuestionSet: (fields[1] as List)
          .map((dynamic e) => (e as Map).map((dynamic k, dynamic v) =>
              MapEntry(k as String, (v as List).cast<String>())))
          .toList(),
    );
  }

  @override
  void write(BinaryWriter writer, ProficiencyQuestionHistoryBox obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.skillQuestionSet)
      ..writeByte(1)
      ..write(obj.jobGroupQuestionSet);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProficiencyQuestionHistoryBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
