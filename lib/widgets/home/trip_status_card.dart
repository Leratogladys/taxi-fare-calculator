import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class TripStatusCard extends StatelessWidget {
  const TripStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: AppColors.white),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "All payments received",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.accent,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  "R360 / R330",
                  style: TextStyle(color: AppColors.secondary),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.chevron_right,
            color: AppColors.secondary,
          )
        ],
      ),
    );
  }
}
