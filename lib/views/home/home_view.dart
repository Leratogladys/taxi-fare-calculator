import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../viewmodels/fare_viewmodels.dart';
import '../../viewmodels/payment_viewmodel.dart';
import '../../widgets/home/trip_status_card.dart';
import '../../widgets/home/total_fare_card.dart';
import '../../widgets/home/stage_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  Future<void> _confirmNewTrip(BuildContext context) async {
    final fareVm = context.read<FareViewmodel>();
    final paymentVm = context.read<PaymentViewmodel>();

    if (fareVm.fare.seats == 0 && paymentVm.payments.isEmpty) return;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Start new trip?',
          style: TextStyle(color: AppColors.accent),
        ),
        content: const Text(
          'The current trip will be saved to history.',
          style: TextStyle(color: AppColors.secondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('New Trip'),
          ),
        ],
      ),
    );
    if (confirm == true && context.mounted) {
      paymentVm.saveAndStartNewTrip(fareVm.fare);
      fareVm.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    final tripId = context.select<FareViewmodel, int>((vm) => vm.tripId);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Taxi Calculator"),
        backgroundColor: AppColors.background,
        elevation: 0,
        actions: [
          TextButton.icon(
            onPressed: () => _confirmNewTrip(context),
            icon: const Icon(Icons.add_road_outlined, size: 18),
            label: const Text('New trip'),
            style: TextButton.styleFrom(foregroundColor: AppColors.accent),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TripStatusCard(),
            const SizedBox(height: 12),
            TotalFareCard(key: ValueKey('fare_$tripId')),
            const SizedBox(height: 12),
            StageCard(key: ValueKey('stage_$tripId')),
            const SizedBox(height: 24),
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
