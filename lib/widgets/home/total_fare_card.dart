import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../viewmodels/fare_viewmodels.dart';

class TotalFareCard extends StatefulWidget {
  const TotalFareCard({super.key});

  @override
  State<TotalFareCard> createState() => _TotalFareCardState();
}

class _TotalFareCardState extends State<TotalFareCard> {
  final _seatsController = TextEditingController();
  final _fareController = TextEditingController();
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final vm = context.read<FareViewmodel>();
      if (vm.fare.seats > 0) {
        _seatsController.text = vm.fare.seats.toString();
      }
      if (vm.fare.farePerPerson > 0) {
        _fareController.text = vm.fare.farePerPerson.toString();
      }
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _seatsController.dispose();
    _fareController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<FareViewmodel>();
    final totalFare = vm.fare.seats * vm.fare.farePerPerson;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "FARE CALCULATION",
            style: TextStyle(
              color: AppColors.secondary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),

          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _InputField(
                  label: 'Seats',
                  controller: _seatsController,
                  onChanged: (v) {
                    final n = int.tryParse(v);
                    if (n != null) context.read<FareViewmodel>().updateSeats(n);
                  },
                ),
              ),

              const SizedBox(width: 12),
              Expanded(
                child: _InputField(
                  label: 'Fare per seat (R)',
                  controller: _fareController,
                  onChanged: (v) {
                    final n = int.tryParse(v);
                    if (n != null) context.read<FareViewmodel>().updateFare(n);
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Fare',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                Text(
                  'R$totalFare',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final void Function(String) onChanged;

  const _InputField({
    required this.label,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.secondary,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          onChanged: onChanged,
          style: const TextStyle(
            color: AppColors.accent,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.background,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            hintText: '0',
            hintStyle: const TextStyle(color: AppColors.secondary),
          ),
        ),
      ],
    );
  }
}
