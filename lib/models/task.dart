import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject{
  @HiveField(0)
  String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String detail;

  Task({required this.id, required this.name, required this.detail});
}