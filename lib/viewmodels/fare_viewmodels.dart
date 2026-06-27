import 'package:flutter/material.dart';
import '../models/fare_model.dart';
import '../core/services/hive_service.dart';

class FareViewmodel extends ChangeNotifier {
  FareModel _fare = FareModel(seats: 0, farePerPerson: 0);
  int _tripId = 0;

  FareModel get fare => _fare;
  int get tripId => _tripId;

  FareViewmodel() {
    _loadFromHive();
  }

  void _loadFromHive() {
    final box = HiveService.activeFareBox;
    if (box.isNotEmpty) _fare = box.getAt(0)!;
  }

  void _persist() {
    final box = HiveService.activeFareBox;
    if (box.isEmpty) {
      box.add(_fare);
    } else {
      box.putAt(0, _fare);
    }
  }

  void updateSeats(int seats) {
    _fare = _fare.copywith(seats: seats);
    _persist();
    notifyListeners();
  }

  void updateFare(int farePerPerson) {
    _fare = _fare.copywith(farePerPerson: farePerPerson);
    _persist();
    notifyListeners();
  }

  void setFare(int seats, int farePerPerson) {
    _fare = _fare.copywith(seats: seats, farePerPerson: farePerPerson);
    _persist();
    notifyListeners();
  }

  void reset() {
    _fare = FareModel(seats: 0, farePerPerson: 0);
    _tripId++;
    HiveService.activeFareBox.clear();
    notifyListeners();
  }
}
