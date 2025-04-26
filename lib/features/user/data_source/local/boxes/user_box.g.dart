// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserBoxAdapter extends TypeAdapter<UserBox> {
  @override
  final int typeId = 0;

  @override
  UserBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserBox(
      hasPracticalInterviewRecord: fields[0] as bool,
      isReviewRequestAvailable: fields[1] as bool,
      hasEnteredFirstInterview: fields[2] == null ? false : fields[2] as bool,
      hasSeenNewYoutubeFeature: fields[3] == null ? false : fields[3] as bool,
      hasProficiencyInterviewRecord:
          fields[4] == null ? false : fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserBox obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.hasPracticalInterviewRecord)
      ..writeByte(1)
      ..write(obj.isReviewRequestAvailable)
      ..writeByte(2)
      ..write(obj.hasEnteredFirstInterview)
      ..writeByte(3)
      ..write(obj.hasSeenNewYoutubeFeature)
      ..writeByte(4)
      ..write(obj.hasProficiencyInterviewRecord);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
