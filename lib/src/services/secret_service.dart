import '../config/env.dart';

/// Service to manage secrets values, like tokens
class SecretService {
  /// Constructor of Secret service
  SecretService({
    this.githubToken,
  });

  /// Github token
  final String githubToken;

  /// Convert json to Secret service model
  static SecretService fromJson(Map<String, dynamic> json) {
    return SecretService(
      githubToken: json['githubToken'] as String,
    );
  }

  static SecretService _flavorService;

  /// Get singleton Secret service
  static SecretService get flavorService {
    if (_flavorService != null) return _flavorService;
    _flavorService = SecretService.fromJson(environment);
    return _flavorService;
  }
}
