// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class notesmodelAdapter extends TypeAdapter<notesmodel> {
  @override
  final int typeId = 1;

  @override
  notesmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return notesmodel(
      title: fields[1] as String,
      description: fields[2] as String,
      date: fields[3] as String,
      color: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, notesmodel obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is notesmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
