import 'package:hive_flutter/hive_flutter.dart';
import 'package:taxi_fare_app/models/route_model.dart';
import '../../models/fare_model.dart';
import '../../models/payment_model.dart';
import '../../models/trip_model.dart';

class HiveService {
  static const String _activeFareBoxName = 'active_fare';
  static const String _activePaymentsBoxName = 'active_payments';
  static const String _tripHistoryBoxName = 'trip_history';
  static const String _routesBoxName = 'routes';

  static Box<FareModel> get activeFareBox =>
      Hive.box<FareModel>(_activeFareBoxName);
  static Box<PaymentModel> get activePaymentBox =>
      Hive.box<PaymentModel>(_activePaymentsBoxName);
  static Box<TripModel> get tripHistoryBox =>
      Hive.box<TripModel>(_tripHistoryBoxName);
  static Box<RouteModel> get routesBox => Hive.box<RouteModel>(_routesBoxName);
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(FareModelAdapter());
    Hive.registerAdapter(PaymentModelAdapter());
    Hive.registerAdapter(TripModelAdapter());
    Hive.registerAdapter(RouteModelAdapter());
    await Hive.openBox<FareModel>(_activeFareBoxName);
    await Hive.openBox<PaymentModel>(_activePaymentsBoxName);
    await Hive.openBox<TripModel>(_tripHistoryBoxName);
    await Hive.openBox<RouteModel>(_routesBoxName);
  }
}
