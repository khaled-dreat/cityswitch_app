part of 'user_entites.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserEntitesAdapter extends TypeAdapter<UserEntites> {
  @override
  final int typeId = 0;

  @override
  UserEntites read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserEntites(
      data: fields[0] as UserData?,
      token: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserEntites obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.data)
      ..writeByte(1)
      ..write(obj.token);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntitesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
