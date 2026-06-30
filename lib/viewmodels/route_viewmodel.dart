import 'package:flutter/material.dart';
import '../models/route_model.dart';
import '../core/services/hive_service.dart';

class RouteViewmodel extends ChangeNotifier {
  List<RouteModel> _routes = [];

  List<RouteModel> get routes => _routes;
  bool get hasRoutes => _routes.isNotEmpty;

  RouteViewmodel() {
    _loadFromHive();
  }

  void _loadFromHive() {
    _routes = HiveService.routesBox.values.toList();
  }

  Future<void> addRoute({
    required String from,
    required String to,
    required int fare,
  }) async {
    final route = RouteModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      from: from,
      to: to,
      fare: fare,
    );

    _routes.add(route);
    notifyListeners();
    await HiveService.routesBox.put(route.id, route);
  }

  Future<void> deleteRoute(String id) async {
    _routes.removeWhere((r) => r.id == id);
    notifyListeners();
    await HiveService.routesBox.delete(id);
  }
}
