// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PriorityAdapter extends TypeAdapter<Priority> {
  @override
  final int typeId = 1;

  @override
  Priority read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Priority.low;
      case 1:
        return Priority.medium;
      case 2:
        return Priority.high;
      case 3:
        return Priority.urgent;
      default:
        return Priority.low;
    }
  }

  @override
  void write(BinaryWriter writer, Priority obj) {
    switch (obj) {
      case Priority.low:
        writer.writeByte(0);
        break;
      case Priority.medium:
        writer.writeByte(1);
        break;
      case Priority.high:
        writer.writeByte(2);
        break;
      case Priority.urgent:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PriorityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RecurrenceAdapter extends TypeAdapter<Recurrence> {
  @override
  final int typeId = 2;

  @override
  Recurrence read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Recurrence.none;
      case 1:
        return Recurrence.daily;
      case 2:
        return Recurrence.weekly;
      case 3:
        return Recurrence.monthly;
      default:
        return Recurrence.none;
    }
  }

  @override
  void write(BinaryWriter writer, Recurrence obj) {
    switch (obj) {
      case Recurrence.none:
        writer.writeByte(0);
        break;
      case Recurrence.daily:
        writer.writeByte(1);
        break;
      case Recurrence.weekly:
        writer.writeByte(2);
        break;
      case Recurrence.monthly:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecurrenceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String?,
      notes: fields[3] as String?,
      priority: fields[4] as Priority,
      category: fields[5] as String?,
      recurrence: fields[6] as Recurrence,
      dueDate: fields[7] as DateTime,
      reminderDate: fields[8] as DateTime?,
      isCompleted: fields[9] as bool,
      isFavorite: fields[10] as bool,
      color: fields[11] as int,
      tags: (fields[12] as List?)?.cast<String>(),
      language: fields[13] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.notes)
      ..writeByte(4)
      ..write(obj.priority)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.recurrence)
      ..writeByte(7)
      ..write(obj.dueDate)
      ..writeByte(8)
      ..write(obj.reminderDate)
      ..writeByte(9)
      ..write(obj.isCompleted)
      ..writeByte(10)
      ..write(obj.isFavorite)
      ..writeByte(11)
      ..write(obj.color)
      ..writeByte(12)
      ..write(obj.tags)
      ..writeByte(13)
      ..write(obj.language);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
