//import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../viewmodels/fare_viewmodels.dart';
import '../../viewmodels/payment_viewmodel.dart';

class StageCard extends StatefulWidget {
  const StageCard({super.key});

  @override
  State<StageCard> createState() => _StageCardState();
}

class _StageCardState extends State<StageCard> {
  final _passengerController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _passengerController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    final passengers = int.tryParse(_amountController.text);
    final amount = int.tryParse(_amountController.text);
    final fare = context.read<FareViewmodel>().fare.farePerPerson;

    if (fare == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Set fare per seat above first')),
      );
      return;
    }

    if (passengers == null || passengers == 0 || amount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter valid passengers and amount')),
      );
      return;
    }

    context.read<PaymentViewmodel>().addPayment(
      amount: amount,
      passengers: passengers,
      farePerPassengers: fare,
    );

    _passengerController.clear();
    _amountController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final fare = context.watch<FareViewmodel>().fare.farePerPerson;
    final paymentVm = context.watch<PaymentViewmodel>();

    final passengers = int.tryParse(_passengerController.text) ?? 0;
    final amount = int.tryParse(_amountController.text) ?? 0;
    final due = passengers * fare;
    final change = amount - due;
    final showPreview = fare > 0 && passengers > 0 && amount > 0;

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
            'RECORD PAYMENT',
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
                  label: 'Passangers',
                  controller: _passengerController,
                  onChanged: (_) => setState(() {}),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _InputField(
                  label: 'Amount paid (R)',
                  controller: _amountController,
                  onChanged: (_) => setState(() {}),
                ),
              ),
            ],
          ),
          if (showPreview) ...[
            const SizedBox(height: 14),
            _PreviewRow(label: 'Amount due', value: 'R$due'),
            const SizedBox(height: 4),
            _PreviewRow(
              label: change >= 0 ? 'Change to give' : 'Shortfall',
              value: 'R${change.abs()}',
              isHighlight: true,
              isError: change < 0,
            ),
          ],

          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _submit(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Record Payment',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
            ),
          ),
          if (paymentVm.payments.isNotEmpty) ...[
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${paymentVm.passengersPaid} pax paid',
                    style: const TextStyle(
                      color: AppColors.secondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'R${paymentVm.totalPaid} collected',
                    style: const TextStyle(
                      color: AppColors.accent,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
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

class _PreviewRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isHighlight;
  final bool isError;

  const _PreviewRow({
    required this.label,
    required this.value,
    this.isHighlight = false,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isError
        ? Colors.red.shade700
        : isHighlight
        ? AppColors.accent
        : AppColors.secondary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
