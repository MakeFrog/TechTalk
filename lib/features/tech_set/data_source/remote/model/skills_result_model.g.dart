// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skills_result_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SkillsResultModelAdapter extends TypeAdapter<SkillsResultModel> {
  @override
  final int typeId = 5;

  @override
  SkillsResultModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SkillsResultModel(
      key: fields[0] as String,
      items: (fields[1] as List)
          .map((dynamic e) => (e as Map).map((dynamic k, dynamic v) =>
              MapEntry(k as String, (v as List).cast<dynamic>())))
          .toList(),
    );
  }

  @override
  void write(BinaryWriter writer, SkillsResultModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SkillsResultModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkillsResultModel _$SkillsResultModelFromJson(Map<String, dynamic> json) =>
    SkillsResultModel(
      key: json['key'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => (e as Map<String, dynamic>).map(
                (k, e) => MapEntry(k, e as List<dynamic>),
              ))
          .toList(),
    );

Map<String, dynamic> _$SkillsResultModelToJson(SkillsResultModel instance) =>
    <String, dynamic>{
      'key': instance.key,
      'items': instance.items,
    };
