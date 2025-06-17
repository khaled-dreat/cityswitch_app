// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../data/models/user_model/user_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDataAdapter extends TypeAdapter<UserData> {
  @override
  final int typeId = 1; // تأكد أن الرقم نفسه الموجود في @HiveType

  @override
  UserData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserData(
      name: fields[0] as String?,
      email: fields[1] as String?,
      password: fields[2] as String?,
      role: fields[3] as String?,
      active: fields[4] as bool?,
      wishlist: (fields[5] as List?)?.cast<dynamic>(),
      id: fields[6] as String?,
      addresses: (fields[7] as List?)?.cast<dynamic>(),
      createdAt: fields[8] as DateTime?,
      updatedAt: fields[9] as DateTime?,
      v: fields[10] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, UserData obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.role)
      ..writeByte(4)
      ..write(obj.active)
      ..writeByte(5)
      ..write(obj.wishlist)
      ..writeByte(6)
      ..write(obj.id)
      ..writeByte(7)
      ..write(obj.addresses)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt)
      ..writeByte(10)
      ..write(obj.v);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
