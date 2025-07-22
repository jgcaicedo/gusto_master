// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gusto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

/// Adaptador para serializar y deserializar objetos Gusto en Hive.
class GustoAdapter extends TypeAdapter<Gusto> {
  @override
  final int typeId = 0;

  @override
  Gusto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Gusto(
      id: fields[0] as String,
      nombre: fields[1] as String,
      imagenUrl: fields[2] as String,
      apiName: fields[3] as String,
      tipos: (fields[4] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Gusto obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nombre)
      ..writeByte(2)
      ..write(obj.imagenUrl)
      ..writeByte(3)
      ..write(obj.apiName)
      ..writeByte(4)
      ..write(obj.tipos);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GustoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
