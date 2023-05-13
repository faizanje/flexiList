import 'package:hive/hive.dart';

part 'task_status.g.dart';

@HiveType(typeId: 3)
enum TASK_STATUS {
  @HiveField(0)
  TODO,

  @HiveField(1)
  LATER,

  @HiveField(2)
  DONE,
}
