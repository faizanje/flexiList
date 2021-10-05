// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoItemModelAdapter extends TypeAdapter<TodoItemModel> {
  @override
  final int typeId = 1;

  @override
  TodoItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoItemModel(
      taskName: fields[0] as String,
      isChecked: fields[1] as bool?,
      taskStatus: fields[3] as TASK_STATUS,
      price: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TodoItemModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.taskName)
      ..writeByte(1)
      ..write(obj.isChecked)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.taskStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
