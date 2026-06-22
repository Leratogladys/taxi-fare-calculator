import 'package:flutter/material.dart';
import 'package:taxi_fare_app/widgets/home/trip_status_card.dart';
import '../../core/theme/app_colors.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Taxi Calculator"),
        backgroundColor: AppColors.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TripStatusCard(),
            const SizedBox(height: 10),
            _card("Fare Calculation"),
            const SizedBox(height: 10),
            _card("Record Payment"),
          ],
        ),
      ),
    );
  }

  Widget _card(String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text, style: const TextStyle(color: AppColors.accent)),
    );
  }
}