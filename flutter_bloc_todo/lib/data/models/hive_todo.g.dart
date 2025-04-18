// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_todo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveTodoAdapter extends TypeAdapter<HiveTodo> {
  @override
  final int typeId = 0;

  @override
  HiveTodo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveTodo()
      ..id = fields[0] as int
      ..body = fields[1] as String
      ..isCompleted = fields[2] as bool;
  }

  @override
  void write(BinaryWriter writer, HiveTodo obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.body)
      ..writeByte(2)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveTodoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
