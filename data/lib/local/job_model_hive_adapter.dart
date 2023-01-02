import 'package:domain/models/job_local_model.dart';
import 'package:hive_flutter/adapters.dart';

//Adapter for Hive, read and save DataModel class objects as Hive objects
class JobLocalModelAdapter extends TypeAdapter<JobLocalModel> {
  @override
  final int typeId = 1;

  @override
  JobLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return JobLocalModel(
      jobLocalID: fields[0] as int,
      jobID: fields[1] as int,
      companyID: fields[2] as int,
      title: fields[3] as String,
      description: fields[4] as String,
      city: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, JobLocalModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.jobLocalID)
      ..writeByte(1)
      ..write(obj.jobID)
      ..writeByte(2)
      ..write(obj.companyID)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.city);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
