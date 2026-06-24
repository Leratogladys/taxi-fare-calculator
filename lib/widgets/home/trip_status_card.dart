import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../viewmodels/fare_viewmodels.dart';
import '../../viewmodels/payment_viewmodel.dart';

class TripStatusCard extends StatelessWidget {
  const TripStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    final fareVm = context.watch<FareViewmodel>();
    final paymentVm = context.watch<PaymentViewmodel>();

    final totalFare = fareVm.fare.seats * fareVm.fare.farePerPerson;
    final totalPaid = paymentVm.totalPaid;
    final tripStarted = totalFare > 0;
    final allPaid = tripStarted && totalPaid >= totalFare;

    final statusText = !tripStarted
        ? 'No trip started'
        : allPaid
            ? 'All payments received'
            : 'Awaiting payments';

    final amountText = tripStarted ? 'R$totalPaid / R$totalFare' : '—';

    final iconData = !tripStarted
        ? Icons.directions_car_outlined
        : allPaid
            ? Icons.check
            : Icons.access_time_outlined;

    final iconColor = !tripStarted
        ? AppColors.secondary
        : allPaid
            ? AppColors.primary
            : const Color(0xFFE07B39); // amber warning

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: iconColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Text(
                    statusText,
                    key: ValueKey(statusText),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.accent,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  amountText,
                  style: const TextStyle(color: AppColors.secondary),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.secondary),
        ],
      ),
    );
  }
}