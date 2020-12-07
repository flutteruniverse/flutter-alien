import '../config/env.dart';

class SecretService {
  SecretService({
    this.githubToken,
  });
  final String githubToken;

  static SecretService fromJson(Map<String, dynamic> json) {
    return SecretService(
      githubToken: json['githubToken'] as String,
    );
  }

  static SecretService _flavorService;
  static SecretService get flavorService {
    if (_flavorService != null) return _flavorService;
    _flavorService = SecretService.fromJson(environment);
    return _flavorService;
  }
}
