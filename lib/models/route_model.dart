import 'package:hive/hive.dart';

class RouteModel {
  final String id;
  final String from;
  final String to;
  final int fare;

  RouteModel({
    required this.id,
    required this.from,
    required this.to,
    required this.fare,
  });

  String get displayName => '$from  → $to';
}

class RouteModelAdapter extends TypeAdapter<RouteModel> {
  @override
  final int typeId = 3;

  @override
  RouteModel read(BinaryReader reader) {
    return RouteModel(
      id: reader.readString(),
      from: reader.readString(),
      to: reader.readString(),
      fare: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, RouteModel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.from);
    writer.writeString(obj.to);
     writer.writeInt(obj.fare);
  }
}
