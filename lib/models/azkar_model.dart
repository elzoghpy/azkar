// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part "azkar_model.g.dart";

@HiveType(typeId: 0)
class MorningModel extends HiveObject {
  @HiveField(0)
  bool isAllowed;

  @HiveField(1)
  DateTime startTime;

  @HiveField(2)
  int endTime;

  @HiveField(3)
  int intervalTime;

  MorningModel({
    required this.isAllowed,
    required this.startTime,
    required this.endTime,
    required this.intervalTime,
  });
}

@HiveType(typeId: 1)
class NightModel extends HiveObject {
  @HiveField(0)
  bool isAllowed;

  @HiveField(1)
  DateTime startTime;

  @HiveField(2)
  int endTime;

  @HiveField(3)
  int intervalTime;

  NightModel({
    required this.isAllowed,
    required this.startTime,
    required this.endTime,
    required this.intervalTime,
  });
}

@HiveType(typeId: 2)
class SalahModel extends HiveObject {
  @HiveField(0)
  bool isAllowed;

  @HiveField(1)
  DateTime startTime;

  @HiveField(2)
  int endTime;

  @HiveField(3)
  int intervalTime;

  SalahModel({
    required this.isAllowed,
    required this.startTime,
    required this.endTime,
    required this.intervalTime,
  });
}

@HiveType(typeId: 3)
class SleepModel extends HiveObject {
  @HiveField(0)
  bool isAllowed;

  @HiveField(1)
  DateTime startTime;

  @HiveField(2)
  int endTime;

  @HiveField(3)
  int intervalTime;

  SleepModel({
    required this.isAllowed,
    required this.startTime,
    required this.endTime,
    required this.intervalTime,
  });
}

@HiveType(typeId: 4)
class HadiseModel extends HiveObject {
  @HiveField(0)
  bool isAllowed;

  @HiveField(1)
  DateTime startTime;

  @HiveField(2)
  int endTime;

  @HiveField(3)
  int intervalTime;

  HadiseModel({
    required this.isAllowed,
    required this.startTime,
    required this.endTime,
    required this.intervalTime,
  });
}

@HiveType(typeId: 5)
class PrayModel extends HiveObject {
  @HiveField(0)
  bool isAllowed;

  @HiveField(1)
  DateTime startTime;

  @HiveField(2)
  int endTime;

  @HiveField(3)
  int intervalTime;

  PrayModel({
    required this.isAllowed,
    required this.startTime,
    required this.endTime,
    required this.intervalTime,
  });
}

@HiveType(typeId: 6)
class AfterSalahModel extends HiveObject {
  @HiveField(0)
  bool isAllowed;

  @HiveField(1)
  DateTime startTime;

  @HiveField(2)
  int endTime;

  @HiveField(3)
  int intervalTime;

  AfterSalahModel({
    required this.isAllowed,
    required this.startTime,
    required this.endTime,
    required this.intervalTime,
  });
}
