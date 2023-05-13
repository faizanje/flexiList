// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TASKSTATUSAdapter extends TypeAdapter<TASK_STATUS> {
  @override
  final int typeId = 3;

  @override
  TASK_STATUS read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TASK_STATUS.TODO;
      case 1:
        return TASK_STATUS.LATER;
      case 2:
        return TASK_STATUS.DONE;
      default:
        return TASK_STATUS.TODO;
    }
  }

  @override
  void write(BinaryWriter writer, TASK_STATUS obj) {
    switch (obj) {
      case TASK_STATUS.TODO:
        writer.writeByte(0);
        break;
      case TASK_STATUS.LATER:
        writer.writeByte(1);
        break;
      case TASK_STATUS.DONE:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TASKSTATUSAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
