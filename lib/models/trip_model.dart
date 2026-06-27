import 'package:hive/hive.dart';
import 'fare_model.dart';
import 'payment_model.dart';

class TripModel {
  final FareModel fare;
  final List<PaymentModel> payments;
  final DateTime completedAt;

  TripModel({
    required this.fare,
    required this.payments,
    required this.completedAt,
  });

  int get totalFare       => fare.seats * fare.farePerPerson;
  int get totalCollected  => payments.fold(0, (sum, p) => sum + p.amount);
  int get totalPassengers => payments.fold(0, (sum, p) => sum + p.passengers);
  int get totalChange     => payments.fold(0, (sum, p) => sum + p.change);
}

class TripModelAdapter extends TypeAdapter<TripModel> {
  @override
  final int typeId = 2;

  @override
  TripModel read(BinaryReader reader) {
    final seats         = reader.readInt();
    final farePerPerson = reader.readInt();
    final completedAt   = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
    final count         = reader.readInt();
    final payments      = List.generate(
      count,
      (_) => PaymentModel(
        amount:     reader.readInt(),
        passengers: reader.readInt(),
        change:     reader.readInt(),
        completed:  reader.readBool(),
      ),
    );
    return TripModel(
      fare:        FareModel(seats: seats, farePerPerson: farePerPerson),
      payments:    payments,
      completedAt: completedAt,
    );
  }

  @override
  void write(BinaryWriter writer, TripModel obj) {
    writer.writeInt(obj.fare.seats);
    writer.writeInt(obj.fare.farePerPerson);
    writer.writeInt(obj.completedAt.millisecondsSinceEpoch);
    writer.writeInt(obj.payments.length);
    for (final p in obj.payments) {
      writer.writeInt(p.amount);
      writer.writeInt(p.passengers);
      writer.writeInt(p.change);
      writer.writeBool(p.completed);
    }
  }
}