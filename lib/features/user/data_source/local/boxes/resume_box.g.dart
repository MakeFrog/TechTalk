// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResumeBoxAdapter extends TypeAdapter<ResumeBox> {
  @override
  final int typeId = 5;

  @override
  ResumeBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ResumeBox(
      resumePath: fields[0] as String?,
      resumeTitle: fields[1] as String?,
      resumeUploadAt: fields[2] as String?,
      resumeExtractedText: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ResumeBox obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.resumePath)
      ..writeByte(1)
      ..write(obj.resumeTitle)
      ..writeByte(2)
      ..write(obj.resumeUploadAt)
      ..writeByte(3)
      ..write(obj.resumeExtractedText);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResumeBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
