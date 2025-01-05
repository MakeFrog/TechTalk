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
      hasEnteredFirstInterview: fields[2] == null ? true : fields[2] as bool,
      resumePdfPath: fields[3] as String?,
      resumePdfTitle: fields[4] as String?,
      resumePdfDate: fields[5] as String?,
      portfolioPdfPath: fields[6] as String?,
      portfolioPdfTitle: fields[7] as String?,
      portfolioPdfDate: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserBox obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.hasPracticalInterviewRecord)
      ..writeByte(1)
      ..write(obj.isReviewRequestAvailable)
      ..writeByte(2)
      ..write(obj.hasEnteredFirstInterview)
      ..writeByte(3)
      ..write(obj.resumePdfPath)
      ..writeByte(4)
      ..write(obj.resumePdfTitle)
      ..writeByte(5)
      ..write(obj.resumePdfDate)
      ..writeByte(6)
      ..write(obj.portfolioPdfPath)
      ..writeByte(7)
      ..write(obj.portfolioPdfTitle)
      ..writeByte(8)
      ..write(obj.portfolioPdfDate);
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
