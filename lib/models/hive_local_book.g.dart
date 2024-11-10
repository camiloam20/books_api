// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_local_book.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveLocalBookAdapter extends TypeAdapter<HiveLocalBook> {
  @override
  final int typeId = 0;

  @override
  HiveLocalBook read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveLocalBook()
      ..id = fields[0] as String?
      ..title = fields[1] as String?
      ..thumbnail = fields[2] as String?
      ..authors = fields[3] as String?
      ..publisher = fields[4] as String?
      ..publishedDate = fields[5] as String?
      ..categories = fields[6] as String?
      ..pageCount = fields[7] as String?
      ..averageRating = fields[8] as String?
      ..description = fields[9] as String?;
  }

  @override
  void write(BinaryWriter writer, HiveLocalBook obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.thumbnail)
      ..writeByte(3)
      ..write(obj.authors)
      ..writeByte(4)
      ..write(obj.publisher)
      ..writeByte(5)
      ..write(obj.publishedDate)
      ..writeByte(6)
      ..write(obj.categories)
      ..writeByte(7)
      ..write(obj.pageCount)
      ..writeByte(8)
      ..write(obj.averageRating)
      ..writeByte(9)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveLocalBookAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
