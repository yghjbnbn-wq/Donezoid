import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
enum Priority {
  @HiveField(0)
  low,
  @HiveField(1)
  medium,
  @HiveField(2)
  high,
  @HiveField(3)
  urgent
}

@HiveType(typeId: 2)
enum Recurrence {
  @HiveField(0)
  none,
  @HiveField(1)
  daily,
  @HiveField(2)
  weekly,
  @HiveField(3)
  monthly
}

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String? notes;

  @HiveField(4)
  late Priority priority;

  @HiveField(5)
  String? category;

  @HiveField(6)
  late Recurrence recurrence;

  @HiveField(7)
  late DateTime dueDate;

  @HiveField(8)
  DateTime? reminderDate;

  @HiveField(9)
  late bool isCompleted;

  @HiveField(10)
  late bool isFavorite;

  @HiveField(11)
  late int color;

  @HiveField(12)
  List<String>? tags;

  @HiveField(13)
  String? language;

  Task({
    required this.id,
    required this.title,
    this.description,
    this.notes,
    this.priority = Priority.medium,
    this.category,
    this.recurrence = Recurrence.none,
    required this.dueDate,
    this.reminderDate,
    this.isCompleted = false,
    this.isFavorite = false,
    required this.color,
    this.tags,
    this.language,
  });
}
