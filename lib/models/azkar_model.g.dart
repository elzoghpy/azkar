// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'azkar_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MorningModelAdapter extends TypeAdapter<MorningModel> {
  @override
  final int typeId = 0;

  @override
  MorningModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MorningModel(
      isAllowed: fields[0] as bool,
      startTime: fields[1] as DateTime,
      endTime: fields[2] as int,
      intervalTime: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MorningModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.isAllowed)
      ..writeByte(1)
      ..write(obj.startTime)
      ..writeByte(2)
      ..write(obj.endTime)
      ..writeByte(3)
      ..write(obj.intervalTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MorningModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NightModelAdapter extends TypeAdapter<NightModel> {
  @override
  final int typeId = 1;

  @override
  NightModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NightModel(
      isAllowed: fields[0] as bool,
      startTime: fields[1] as DateTime,
      endTime: fields[2] as int,
      intervalTime: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, NightModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.isAllowed)
      ..writeByte(1)
      ..write(obj.startTime)
      ..writeByte(2)
      ..write(obj.endTime)
      ..writeByte(3)
      ..write(obj.intervalTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NightModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SalahModelAdapter extends TypeAdapter<SalahModel> {
  @override
  final int typeId = 2;

  @override
  SalahModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SalahModel(
      isAllowed: fields[0] as bool,
      startTime: fields[1] as DateTime,
      endTime: fields[2] as int,
      intervalTime: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SalahModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.isAllowed)
      ..writeByte(1)
      ..write(obj.startTime)
      ..writeByte(2)
      ..write(obj.endTime)
      ..writeByte(3)
      ..write(obj.intervalTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SalahModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SleepModelAdapter extends TypeAdapter<SleepModel> {
  @override
  final int typeId = 3;

  @override
  SleepModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SleepModel(
      isAllowed: fields[0] as bool,
      startTime: fields[1] as DateTime,
      endTime: fields[2] as int,
      intervalTime: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SleepModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.isAllowed)
      ..writeByte(1)
      ..write(obj.startTime)
      ..writeByte(2)
      ..write(obj.endTime)
      ..writeByte(3)
      ..write(obj.intervalTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SleepModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HadiseModelAdapter extends TypeAdapter<HadiseModel> {
  @override
  final int typeId = 4;

  @override
  HadiseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HadiseModel(
      isAllowed: fields[0] as bool,
      startTime: fields[1] as DateTime,
      endTime: fields[2] as int,
      intervalTime: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HadiseModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.isAllowed)
      ..writeByte(1)
      ..write(obj.startTime)
      ..writeByte(2)
      ..write(obj.endTime)
      ..writeByte(3)
      ..write(obj.intervalTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HadiseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PrayModelAdapter extends TypeAdapter<PrayModel> {
  @override
  final int typeId = 5;

  @override
  PrayModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PrayModel(
      isAllowed: fields[0] as bool,
      startTime: fields[1] as DateTime,
      endTime: fields[2] as int,
      intervalTime: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PrayModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.isAllowed)
      ..writeByte(1)
      ..write(obj.startTime)
      ..writeByte(2)
      ..write(obj.endTime)
      ..writeByte(3)
      ..write(obj.intervalTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrayModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AfterSalahModelAdapter extends TypeAdapter<AfterSalahModel> {
  @override
  final int typeId = 6;

  @override
  AfterSalahModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AfterSalahModel(
      isAllowed: fields[0] as bool,
      startTime: fields[1] as DateTime,
      endTime: fields[2] as int,
      intervalTime: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AfterSalahModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.isAllowed)
      ..writeByte(1)
      ..write(obj.startTime)
      ..writeByte(2)
      ..write(obj.endTime)
      ..writeByte(3)
      ..write(obj.intervalTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AfterSalahModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
