// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_task_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HomeTaskItemModelAdapter extends TypeAdapter<HomeTaskItemModel> {
  @override
  final int typeId = 0;

  @override
  HomeTaskItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HomeTaskItemModel(
      isArchived: fields[0] as bool,
      isCurrencySelected: fields[1] as bool,
      colorValue: (fields[2] as List).cast<int>(),
      todoItemList: (fields[3] as List).cast<TodoItemModel>(),
      title: fields[4] as String?,
    )..dateTime = fields[5] as DateTime;
  }

  @override
  void write(BinaryWriter writer, HomeTaskItemModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.isArchived)
      ..writeByte(1)
      ..write(obj.isCurrencySelected)
      ..writeByte(2)
      ..write(obj.colorValue)
      ..writeByte(3)
      ..write(obj.todoItemList)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeTaskItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
