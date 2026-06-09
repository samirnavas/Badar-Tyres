import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';

/// The "Vehicles" tab — a registry of customer vehicles. The backing data
/// source isn't wired yet, so this presents a polished empty state.
class VehiclesScreen extends StatelessWidget {
  const VehiclesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Vehicles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          const SizedBox(width: AppSpacing.base),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.stackLg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: AppStatusColors.tint(AppColors.primaryContainer),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.directions_car_rounded,
                  size: 44,
                  color: AppColors.primaryContainer,
                ),
              ),
              const SizedBox(height: AppSpacing.stackMd),
              Text(
                'No vehicles yet',
                style: AppTypography.titleSm.copyWith(fontSize: 18),
              ),
              const SizedBox(height: AppSpacing.base),
              Text(
                'Customer vehicles will appear here once job cards are created.',
                textAlign: TextAlign.center,
                style: AppTypography.bodyMd.copyWith(
                  fontSize: 14,
                  color: AppColors.secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
