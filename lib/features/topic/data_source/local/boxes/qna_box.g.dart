// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qna_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QnaBoxAdapter extends TypeAdapter<QnaBox> {
  @override
  final int typeId = 1;

  @override
  QnaBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QnaBox(
      id: fields[0] as String,
      question: fields[1] as String,
      answers: (fields[2] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, QnaBox obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.question)
      ..writeByte(2)
      ..write(obj.answers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QnaBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
