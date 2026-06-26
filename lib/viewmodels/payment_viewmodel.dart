import 'package:flutter/material.dart';
import '../models/payment_model.dart';

class PaymentViewmodel extends ChangeNotifier {
  final List<PaymentModel> _payments = [];

  List<PaymentModel> get payments => _payments;

  int get totalPaid => _payments.fold(0, (sum, p) => sum + p.amount);

  int get passengersPaid => _payments.fold(0, (sum, p) => sum + p.passengers);

  // Return payments with change
  List<MapEntry<int, PaymentModel>> get paymentsWithChange =>
      _payments.asMap().entries.where((e) => e.value.change > 0).toList();

  //Total change still owed

  int get totalPendingChange => _payments
      .where((p) => p.change > 0 && !p.completed)
      .fold(0, (sum, p) => sum + p.change);

  void addPayment({
    required int amount,
    required int passengers,
    required int farePerPassengers,
  }) {
    final totalDue = passengers * farePerPassengers;
    final change = amount - totalDue;

    _payments.add(
      PaymentModel(
        amount: amount,
        passengers: passengers,
        change: change > 0 ? change : 0,
      ),
    );

    notifyListeners();
  }

  void markChangeAsGiven(int index) {
    if (index < 0 || index >= _payments.length) return;
    _payments[index] = _payments[index].copywith(completed: true);

    notifyListeners();
  }

  void clear() {
    _payments.clear();
    notifyListeners();
  }
}
