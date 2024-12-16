// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tech_set_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TechSetBoxAdapter extends TypeAdapter<TechSetBox> {
  @override
  final int typeId = 4;

  @override
  TechSetBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TechSetBox(
      skill: fields[0] as SkillsResultModel,
    );
  }

  @override
  void write(BinaryWriter writer, TechSetBox obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.skill);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TechSetBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
