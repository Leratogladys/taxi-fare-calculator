import 'package:flutter/material.dart';
import '../models/fare_model.dart';
import '../models/route_model.dart';
import '../core/services/hive_service.dart';

class FareViewmodel extends ChangeNotifier {
  FareModel   _fare          = FareModel(seats: 0, farePerPerson: 0);
  int         _tripId        = 0;
  RouteModel? _selectedRoute;

  FareModel   get fare          => _fare;
  int         get tripId        => _tripId;
  RouteModel? get selectedRoute => _selectedRoute;

  FareViewmodel() {
    _loadFromHive();
  }

  void _loadFromHive() {
    final box = HiveService.activeFareBox;
    if (box.isNotEmpty) _fare = box.getAt(0)!;
  }

  Future<void> _persist() async {
    final box = HiveService.activeFareBox;
    if (box.isEmpty) {
      await box.add(_fare);
    } else {
      await box.putAt(0, _fare);
    }
  }

  Future<void> updateSeats(int seats) async {
    _fare = _fare.copywith(seats: seats);
    notifyListeners();
    await _persist();
  }

  Future<void> updateFare(int farePerPerson) async {
    _selectedRoute = null; // manual entry clears route label
    _fare = _fare.copywith(farePerPerson: farePerPerson);
    notifyListeners();
    await _persist();
  }

  // Called by RouteLibrarySheet when a route is tapped
  Future<void> applyRoute(RouteModel route) async {
    _selectedRoute = route;
    _fare = _fare.copywith(farePerPerson: route.fare);
    notifyListeners();
    await _persist();
  }

  Future<void> setFare(int seats, int farePerPerson) async {
    _selectedRoute = null;
    _fare = _fare.copywith(seats: seats, farePerPerson: farePerPerson);
    notifyListeners();
    await _persist();
  }

  Future<void> reset() async {
    _fare          = FareModel(seats: 0, farePerPerson: 0);
    _selectedRoute = null;
    _tripId++;
    notifyListeners();
    await HiveService.activeFareBox.clear();
  }
}