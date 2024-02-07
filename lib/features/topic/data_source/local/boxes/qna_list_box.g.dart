// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qna_list_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QnaListBoxAdapter extends TypeAdapter<QnaListBox> {
  @override
  final int typeId = 2;

  @override
  QnaListBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QnaListBox(
      updatedAt: fields[0] as DateTime,
      items: (fields[1] as List).cast<QnaBox>(),
    );
  }

  @override
  void write(BinaryWriter writer, QnaListBox obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.updatedAt)
      ..writeByte(1)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QnaListBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
