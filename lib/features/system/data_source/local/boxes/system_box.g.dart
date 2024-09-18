// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SystemBoxAdapter extends TypeAdapter<SystemBox> {
  @override
  final int typeId = 3;

  @override
  SystemBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SystemBox(
      languageCode: fields[0] as String,
      virtualKeyboardHeight: fields[1] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, SystemBox obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.languageCode)
      ..writeByte(1)
      ..write(obj.virtualKeyboardHeight);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SystemBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
