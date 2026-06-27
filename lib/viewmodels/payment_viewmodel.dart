import 'package:flutter/material.dart';
import '../models/fare_model.dart';
import '../models/payment_model.dart';
import '../models/trip_model.dart';
import '../core/services/hive_service.dart';

class PaymentViewmodel extends ChangeNotifier {
  List<PaymentModel> _payments = [];

  List<PaymentModel> get payments => _payments;

  int get totalPaid => _payments.fold(0, (sum, p) => sum + p.amount);

  int get passengersPaid => _payments.fold(0, (sum, p) => sum + p.passengers);

  List<MapEntry<int, PaymentModel>> get paymentsWithChange =>
      _payments.asMap().entries.where((e) => e.value.change > 0).toList();

  int get totalPendingChange => _payments
      .where((p) => p.change > 0 && !p.completed)
      .fold(0, (sum, p) => sum + p.change);

  PaymentViewmodel() {
    _loadFromHive();
  }

  void _loadFromHive() {
    _payments = HiveService.activePaymentBox.values.toList();
  }

  void addPayment({
    required int amount,
    required int passengers,
    required int farePerPassengers,
  }) {
    final totalDue = passengers * farePerPassengers;
    final change = amount - totalDue;
    final payment = PaymentModel(
      amount: amount,
      passengers: passengers,
      change: change > 0 ? change : 0,
    );
    _payments.add(payment);
    HiveService.activePaymentBox.add(payment);
    notifyListeners();
  }

  void markChangeAsGiven(int index) {
    if (index < 0 || index >= _payments.length) return;
    _payments[index] = _payments[index].copywith(completed: true);
    HiveService.activePaymentBox.putAt(index, _payments[index]);

    notifyListeners();
  }

  void saveAndStartNewTrip(FareModel fare) {
    if (_payments.isNotEmpty) {
      HiveService.tripHistoryBox.add(
        TripModel(
          fare: fare,
          payments: List.from(_payments),
          completedAt: DateTime.now(),
        ),
      );
    }
    _payments.clear();
    HiveService.activePaymentBox.clear();
    notifyListeners();
  }

  void clear() {
    _payments.clear();
    HiveService.activePaymentBox.clear();
    notifyListeners();
  }
}
