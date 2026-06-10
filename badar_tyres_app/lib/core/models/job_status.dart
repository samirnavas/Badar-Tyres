/// Lifecycle state of a job card, shared between the data layer and the UI.
enum JobStatus { running, completed, delayed, pending }

/// Parses an API status string (e.g. `"running"`) into a [JobStatus],
/// defaulting to [JobStatus.pending] for unknown values.
JobStatus jobStatusFromName(String? name) => switch (name?.toLowerCase()) {
      'running' => JobStatus.running,
      'completed' => JobStatus.completed,
      'delayed' => JobStatus.delayed,
      'pending' => JobStatus.pending,
      _ => JobStatus.pending,
    };
