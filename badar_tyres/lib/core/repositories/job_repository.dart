import '../api/api_client.dart';
import '../models/job.dart';
import '../models/job_metrics.dart';
import '../models/vehicle.dart';

/// Data access for jobs, metrics, and technicians. Talks to the mock REST API
/// via [ApiClient]; swap the client for a real backend without touching the UI.
class JobRepository {
  JobRepository({ApiClient? client}) : _client = client ?? ApiClient();

  final ApiClient _client;

  Future<JobMetrics> fetchMetrics() async {
    final data = await _client.getJson('/metrics');
    return JobMetrics.fromJson(data as Map<String, dynamic>);
  }

  Future<List<Job>> fetchJobs({String status = 'all', String search = ''}) async {
    final data = await _client.getJson('/jobs', query: {
      'status': status,
      'search': search,
    });
    return (data as List<dynamic>)
        .map((e) => Job.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<Vehicle>> fetchVehicles() async {
    final data = await _client.getJson('/vehicles');
    return (data as List<dynamic>)
        .map((e) => Vehicle.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Job> fetchJob(String id) async {
    final data = await _client.getJson('/jobs/$id');
    return Job.fromJson(data as Map<String, dynamic>);
  }

  Future<List<String>> fetchTechnicians() async {
    final data = await _client.getJson('/technicians');
    return (data as List<dynamic>).map((e) => e.toString()).toList();
  }

  Future<Job> createJob(Map<String, dynamic> payload) async {
    final data = await _client.postJson('/jobs', payload);
    return Job.fromJson(data as Map<String, dynamic>);
  }

  void dispose() => _client.dispose();
}
