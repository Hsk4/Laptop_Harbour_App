// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Laptop_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LaptopAdapter extends TypeAdapter<Laptop> {
  @override
  final int typeId = 0;

  @override
  Laptop read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Laptop(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      category: fields[3] as String,
      brand: fields[4] as String,
      imageUrl: fields[5] as String,
      price: fields[6] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Laptop obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.brand)
      ..writeByte(5)
      ..write(obj.imageUrl)
      ..writeByte(6)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LaptopAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
