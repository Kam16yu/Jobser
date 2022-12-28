
import 'package:domain/models/company_local_model.dart';
import 'package:hive_flutter/adapters.dart';

//Adapter for Hive, read and save DataModel class objects as Hive objects
class CompanyLocalModelAdapter extends TypeAdapter<CompanyLocalModel> {
  @override
  final int typeId = 0;

  @override
  CompanyLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return CompanyLocalModel(
      companyLocalID: fields[0] as int,
      companyID: fields[1] as int,
      name: fields[2] as String,
      description: fields[3] as String,
      industry: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CompanyLocalModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.companyLocalID)
      ..writeByte(1)
      ..write(obj.companyID)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.industry)
      ..writeByte(5);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CompanyLocalModelAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
