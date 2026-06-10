import '../api/api_client.dart';
import '../models/user.dart';

/// Authentication data access against the mock REST API.
class AuthRepository {
  AuthRepository({ApiClient? client}) : _client = client ?? ApiClient();

  final ApiClient _client;

  Future<AuthUser> login(String username, String password) async {
    final data = await _client.postJson('/login', {
      'username': username,
      'password': password,
    });
    return AuthUser.fromJson(data as Map<String, dynamic>);
  }

  void dispose() => _client.dispose();
}
