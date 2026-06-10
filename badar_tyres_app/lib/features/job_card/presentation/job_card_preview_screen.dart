import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/models/job.dart';
import '../../../core/models/service_item.dart';
import '../../../core/widgets/job_list_tile.dart';
import '../../../core/theme/theme.dart';
import '../../services/presentation/services_catalog_screen.dart';

class JobCardPreviewScreen extends StatefulWidget {
  const JobCardPreviewScreen({super.key, required this.job});

  final Job job;

  @override
  State<JobCardPreviewScreen> createState() => _JobCardPreviewScreenState();
}

class _JobCardPreviewScreenState extends State<JobCardPreviewScreen> {
  late Job _job;

  @override
  void initState() {
    super.initState();
    _job = widget.job;
  }

  Future<void> _addService() async {
    final result = await Navigator.of(context).push<ServiceItem>(
      MaterialPageRoute(builder: (_) => const ServicesCatalogScreen()),
    );
    if (result != null) {
      final newService = JobService(
        name: result.name,
        description: result.description,
        amount: result.amount,
      );
      final updatedServices = List<JobService>.from(_job.services)..add(newService);
      final subTotal = updatedServices.fold(0.0, (sum, item) => sum + item.amount);
      final gst = subTotal * 0.18;
      final grandTotal = subTotal + gst;

      setState(() {
        _job = Job(
          id: _job.id,
          jobNumber: _job.jobNumber,
          customerName: _job.customerName,
          mobile: _job.mobile,
          vehicleModel: _job.vehicleModel,
          vehicleNumber: _job.vehicleNumber,
          status: _job.status,
          time: _job.time,
          date: _job.date,
          technician: _job.technician,
          startTime: _job.startTime,
          expectedEnd: _job.expectedEnd,
          actualEnd: _job.actualEnd,
          delay: _job.delay,
          remarks: _job.remarks,
          services: updatedServices,
          subTotal: subTotal,
          gst: gst,
          grandTotal: grandTotal,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Job Card Preview'),
        actions: [
          IconButton(
            icon: const Icon(Icons.print_outlined),
            onPressed: () {},
          ),
          const SizedBox(width: AppSpacing.base),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.containerPadding,
          AppSpacing.stackLg,
          AppSpacing.containerPadding,
          48.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Services', style: context.typography.headlineMd),
            const SizedBox(height: 4),
            Text(
              'Choose the service required for this vehicle',
              style: context.typography.bodyMd.copyWith(color: context.colors.secondary),
            ),
            const SizedBox(height: AppSpacing.stackLg),
            _JobCardDetails(job: _job, onAddService: _addService),
          ],
        ),
      ),
    );
  }
}

class _JobCardDetails extends StatelessWidget {
  const _JobCardDetails({required this.job, required this.onAddService});

  final Job job;
  final VoidCallback onAddService;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLowest,
        borderRadius: AppRadius.brXl,
        boxShadow: [
          BoxShadow(
            color: context.colors.shadow.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(context),
          const Divider(height: 1),
          _buildCustomerRow(context),
          const Divider(height: 1),
          _buildVehicleRow(context),
          const Divider(height: 1),
          _buildTechnicianRow(context),
          const Divider(height: 1),
          _buildServicesSection(context),
          _buildTotals(context),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.stackMd),
      child: Row(
        children: [
          _IconCircle(icon: Icons.assignment_outlined, context: context),
          const SizedBox(width: AppSpacing.gutter),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Job Card', style: context.typography.bodyMd),
                Text(
                  job.jobNumber,
                  style: context.typography.titleSm.copyWith(
                    color: context.colors.primary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                job.date,
                style: context.typography.bodyMd.copyWith(
                  fontSize: 14,
                  color: context.colors.secondary,
                ),
              ),
              Text(
                job.status.label,
                style: context.typography.labelSm.copyWith(
                  fontSize: 12,
                  color: job.status.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.stackMd),
      child: Row(
        children: [
          _IconCircle(icon: Icons.person_outline, context: context),
          const SizedBox(width: AppSpacing.gutter),
          Expanded(
            child: Text(
              'Customer',
              style: context.typography.bodyMd.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                job.customerName,
                style: context.typography.bodyMd.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                job.mobile,
                style: context.typography.bodyMd.copyWith(
                  fontSize: 13,
                  color: context.colors.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.stackMd),
      child: Row(
        children: [
          _IconCircle(icon: Icons.directions_car_outlined, context: context),
          const SizedBox(width: AppSpacing.gutter),
          Expanded(
            child: Text(
              'Vehicle',
              style: context.typography.bodyMd.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                job.vehicleNumber,
                style: context.typography.bodyMd.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                job.vehicleModel,
                style: context.typography.bodyMd.copyWith(
                  fontSize: 13,
                  color: context.colors.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTechnicianRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.stackMd),
      child: Row(
        children: [
          _IconCircle(icon: Icons.person_outline, context: context),
          const SizedBox(width: AppSpacing.gutter),
          Expanded(
            child: Text(
              'Technician',
              style: context.typography.bodyMd.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            job.technician,
            style: context.typography.bodyMd.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesSection(BuildContext context) {
    final currency = NumberFormat.currency(symbol: '₹', decimalDigits: 2, customPattern: '\u00A4 #,##0.00');
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.stackMd),
          child: Row(
            children: [
              _IconCircle(icon: Icons.settings_outlined, context: context),
              const SizedBox(width: AppSpacing.gutter),
              Expanded(
                child: Text(
                  'Services',
                  style: context.typography.bodyMd.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              TextButton.icon(
                onPressed: onAddService,
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add New Services'),
                style: TextButton.styleFrom(
                  foregroundColor: context.colors.primary,
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
        ),
        Container(
          color: context.colors.surfaceContainerLowest, // Table header background can just match or be slightly darker.
          child: Table(
            columnWidths: const {
              0: FixedColumnWidth(36),
              1: FlexColumnWidth(1.2),
              2: FlexColumnWidth(1.5),
              3: FlexColumnWidth(1.0),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: context.colors.surfaceContainerLow,
                ),
                children: [
                  _TableHeaderCell(text: '#', context: context),
                  _TableHeaderCell(text: 'Service / Part', context: context),
                  _TableHeaderCell(text: 'Description', context: context),
                  _TableHeaderCell(text: 'Amt (₹)', align: TextAlign.right, context: context),
                ],
              ),
              for (var i = 0; i < job.services.length; i++)
                TableRow(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: context.colors.surfaceContainerHigh),
                    ),
                  ),
                  children: [
                    _TableCell(text: '${i + 1}', context: context),
                    _TableCell(text: job.services[i].name, context: context),
                    _TableCell(text: job.services[i].description, context: context),
                    _TableCell(text: currency.format(job.services[i].amount).replaceAll('₹ ', ''), align: TextAlign.right, context: context),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTotals(BuildContext context) {
    final currency = NumberFormat.currency(symbol: '₹', decimalDigits: 2, customPattern: '\u00A4 #,##0.00');
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.stackMd),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sub Total', style: context.typography.bodyMd),
              Text(currency.format(job.subTotal), style: context.typography.bodyMd.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: AppSpacing.stackSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('GST (18%)', style: context.typography.bodyMd),
              Text(currency.format(job.gst), style: context.typography.bodyMd.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: AppSpacing.stackLg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'GRAND TOTAL',
                style: context.typography.bodyMd.copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                currency.format(job.grandTotal),
                style: context.typography.titleSm.copyWith(
                  color: context.colors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.stackMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Notes:', style: context.typography.bodyMd.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: AppSpacing.stackSm),
          Text(
            job.remarks.isNotEmpty ? job.remarks : 'Customer complained steering vibration.',
            style: context.typography.bodyMd.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 48),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 150,
              child: Column(
                children: [
                  const Divider(thickness: 1),
                  const SizedBox(height: AppSpacing.stackSm),
                  Text(
                    'Customer Signature',
                    style: context.typography.bodyMd,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IconCircle extends StatelessWidget {
  const _IconCircle({required this.icon, required this.context});

  final IconData icon;
  final BuildContext context;

  @override
  Widget build(BuildContext _) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppStatusColors.tint(context.colors.primaryContainer),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: context.colors.primaryContainer),
    );
  }
}

class _TableHeaderCell extends StatelessWidget {
  const _TableHeaderCell({required this.text, this.align = TextAlign.left, required this.context});
  final String text;
  final TextAlign align;
  final BuildContext context;

  @override
  Widget build(BuildContext _) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base, vertical: AppSpacing.stackMd),
      child: Text(
        text,
        textAlign: align,
        style: context.typography.bodyMd.copyWith(fontSize: 13, color: context.colors.secondary),
      ),
    );
  }
}

class _TableCell extends StatelessWidget {
  const _TableCell({required this.text, this.align = TextAlign.left, required this.context});
  final String text;
  final TextAlign align;
  final BuildContext context;

  @override
  Widget build(BuildContext _) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base, vertical: AppSpacing.stackMd),
      child: Text(
        text,
        textAlign: align,
        style: context.typography.bodyMd.copyWith(fontSize: 14),
      ),
    );
  }
}
