// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PortfolioBoxAdapter extends TypeAdapter<PortfolioBox> {
  @override
  final int typeId = 6;

  @override
  PortfolioBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PortfolioBox(
      portfolioPath: fields[0] as String?,
      portfolioTitle: fields[1] as String?,
      portfolioUploadAt: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PortfolioBox obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.portfolioPath)
      ..writeByte(1)
      ..write(obj.portfolioTitle)
      ..writeByte(2)
      ..write(obj.portfolioUploadAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PortfolioBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
