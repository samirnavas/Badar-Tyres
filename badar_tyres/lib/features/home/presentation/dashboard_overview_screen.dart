import 'package:flutter/material.dart';

import '../../../core/api/api_client.dart';
import '../../../core/models/job_metrics.dart';
import '../../../core/repositories/job_repository.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/metric_card.dart';
import '../../services/presentation/services_catalog_screen.dart';

/// The "Dashboard" home tab: a welcome header, the live job metrics, and quick
/// shortcuts into the most common workflows (create a job, browse services).
class DashboardOverviewScreen extends StatefulWidget {
  const DashboardOverviewScreen({
    super.key,
    required this.onCreateJob,
    required this.onViewJobs,
  });

  final VoidCallback onCreateJob;
  final VoidCallback onViewJobs;

  @override
  State<DashboardOverviewScreen> createState() =>
      _DashboardOverviewScreenState();
}

class _DashboardOverviewScreenState extends State<DashboardOverviewScreen> {
  final JobRepository _repository = JobRepository();
  JobMetrics _metrics = JobMetrics.empty;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadMetrics();
  }

  @override
  void dispose() {
    _repository.dispose();
    super.dispose();
  }

  Future<void> _loadMetrics() async {
    setState(() => _loading = true);
    try {
      final metrics = await _repository.fetchMetrics();
      if (!mounted) return;
      setState(() => _metrics = metrics);
    } on ApiException {
      // Keep last-known metrics on failure.
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  String _metric(int value) =>
      (_loading && _metrics.totalJobs == 0) ? '—' : '$value';

  void _openServices() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ServicesCatalogScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {},
          ),
          const SizedBox(width: AppSpacing.base),
        ],
      ),
      body: RefreshIndicator(
        color: AppColors.primary,
        backgroundColor: AppColors.surfaceContainerHigh,
        onRefresh: _loadMetrics,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.containerPadding,
            AppSpacing.stackMd,
            AppSpacing.containerPadding,
            AppSpacing.stackLg,
          ),
          children: [
            Text('Welcome back', style: AppTypography.bodyMd.copyWith(
              color: AppColors.secondary,
            )),
            const SizedBox(height: AppSpacing.stackSm),
            Text('Badar Tyres', style: AppTypography.displayLgMobile),
            const SizedBox(height: AppSpacing.stackLg),
            Text('Overview', style: AppTypography.titleSm.copyWith(fontSize: 16)),
            const SizedBox(height: AppSpacing.gutter),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: AppSpacing.gutter,
              mainAxisSpacing: AppSpacing.gutter,
              childAspectRatio: 2.2,
              children: [
                MetricCard.totalJobs(value: _metric(_metrics.totalJobs)),
                MetricCard.running(value: _metric(_metrics.running)),
                MetricCard.completed(value: _metric(_metrics.completed)),
                MetricCard.delayed(value: _metric(_metrics.delayed)),
              ],
            ),
            const SizedBox(height: AppSpacing.stackLg),
            Text('Quick Actions',
                style: AppTypography.titleSm.copyWith(fontSize: 16)),
            const SizedBox(height: AppSpacing.gutter),
            _QuickAction(
              icon: Icons.add_circle_outline,
              title: 'Create Job Card',
              subtitle: 'Start a new service job',
              onTap: widget.onCreateJob,
            ),
            const SizedBox(height: AppSpacing.gutter),
            _QuickAction(
              icon: Icons.build_circle_outlined,
              title: 'Services',
              subtitle: 'Browse the full service menu',
              onTap: _openServices,
            ),
            const SizedBox(height: AppSpacing.gutter),
            _QuickAction(
              icon: Icons.work_outline,
              title: 'View All Jobs',
              subtitle: 'Track running & completed work',
              onTap: widget.onViewJobs,
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceContainerLow,
      borderRadius: AppRadius.brLg,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: AppRadius.brLg,
            border: Border.all(color: AppColors.outlineVariant, width: 1),
          ),
          padding: const EdgeInsets.all(AppSpacing.stackMd),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppStatusColors.tint(AppColors.primaryContainer),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(icon, color: AppColors.primaryContainer, size: 24),
              ),
              const SizedBox(width: AppSpacing.gutter),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(title,
                        style: AppTypography.bodyMd
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTypography.bodyMd.copyWith(
                        fontSize: 13,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded,
                  color: AppColors.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
