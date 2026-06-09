import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../../../core/models/vehicle.dart';
import '../../../core/repositories/job_repository.dart';

/// The "Vehicles" tab — a registry of customer vehicles.
class VehiclesScreen extends StatefulWidget {
  const VehiclesScreen({super.key});

  @override
  State<VehiclesScreen> createState() => _VehiclesScreenState();
}

class _VehiclesScreenState extends State<VehiclesScreen> {
  final _repository = JobRepository();
  bool _isLoading = true;
  List<Vehicle> _vehicles = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadVehicles();
  }

  Future<void> _loadVehicles() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final vehicles = await _repository.fetchVehicles();
      if (!mounted) return;
      setState(() {
        _vehicles = vehicles;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _repository.dispose();
    super.dispose();
  }

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
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.stackLg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: AppSpacing.stackMd),
              Text(
                'Failed to load vehicles',
                style: AppTypography.titleSm.copyWith(color: AppColors.error),
              ),
              const SizedBox(height: AppSpacing.base),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: AppTypography.bodyMd,
              ),
              const SizedBox(height: AppSpacing.stackLg),
              ElevatedButton(
                onPressed: _loadVehicles,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_vehicles.isEmpty) {
      return Center(
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
      );
    }

    return RefreshIndicator(
      onRefresh: _loadVehicles,
      child: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.containerPadding),
        itemCount: _vehicles.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.stackMd),
        itemBuilder: (context, index) {
          final vehicle = _vehicles[index];
          return _VehicleCard(vehicle: vehicle);
        },
      ),
    );
  }
}

class _VehicleCard extends StatelessWidget {
  const _VehicleCard({required this.vehicle});

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: AppRadius.brLg,
        border: Border.all(color: AppColors.outlineVariant, width: 1),
      ),
      padding: const EdgeInsets.all(AppSpacing.stackMd),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh,
              borderRadius: AppRadius.brBase,
            ),
            alignment: Alignment.center,
            child: Icon(
              vehicle.vehicleType.toLowerCase() == 'bike'
                  ? Icons.two_wheeler_rounded
                  : Icons.directions_car_rounded,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppSpacing.stackMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vehicle.vehicleNumber.isNotEmpty ? vehicle.vehicleNumber : 'Unknown Reg',
                  style: AppTypography.titleSm,
                ),
                const SizedBox(height: 4),
                Text(
                  [
                    if (vehicle.vehicleModel.isNotEmpty) vehicle.vehicleModel,
                    if (vehicle.customerName.isNotEmpty) vehicle.customerName,
                  ].join(' • '),
                  style: AppTypography.bodyMd.copyWith(
                    color: AppColors.secondary,
                    fontSize: 13,
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
