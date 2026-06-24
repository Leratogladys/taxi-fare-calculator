import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/home/trip_status_card.dart';
import '../../widgets/home/total_fare_card.dart';
import '../../widgets/home/stage_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Taxi Calculator"),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: const Column(
          children: [
            TripStatusCard(),
            SizedBox(height: 12),
            TotalFareCard(),
            SizedBox(height: 12),
            StageCard(),
            SizedBox(height: 24),
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