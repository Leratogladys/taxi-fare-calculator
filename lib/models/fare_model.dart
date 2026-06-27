import 'package:hive/hive.dart';

class FareModel {
  final int seats;
  final int farePerPerson;

  FareModel({required this.seats, required this.farePerPerson});

  int get totalFare => seats * farePerPerson;

  FareModel copywith({int? seats, int? farePerPerson}) {
    return FareModel(
      seats: seats ?? this.seats,
      farePerPerson: farePerPerson ?? this.farePerPerson,
    );
  }
}

class FareModelAdapter extends TypeAdapter<FareModel> {
  @override
  final int typeId = 0;

  @override
  FareModel read(BinaryReader reader) {
    return FareModel(seats: reader.readInt(), farePerPerson: reader.readInt());
  }

  @override
  void write(BinaryWriter writer, FareModel obj) {
    writer.writeInt(obj.seats);
    writer.writeInt(obj.farePerPerson);
  }
}
