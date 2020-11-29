import 'package:flutter_alien/config/env.dart';

class SecretService {
  SecretService({
    this.spotifyClientId,
    this.spotifyClientSecret,
    this.twitterApiKey,
    this.twitterSecretKey,
    this.twitterToken,
    this.twitterTokenSecret,
    this.telegramApiKey,
  });
  final String spotifyClientId;
  final String spotifyClientSecret;
  final String twitterApiKey;
  final String twitterSecretKey;
  final String twitterToken;
  final String twitterTokenSecret;
  final String telegramApiKey;

  static SecretService fromJson(Map<String, dynamic> json) {
    return SecretService(
      spotifyClientId: json['spotifyClientId'] as String,
      spotifyClientSecret: json['spotifyClientSecret'] as String,
      twitterApiKey: json['twitterApiKey'] as String,
      twitterSecretKey: json['twitterSecretKey'] as String,
      twitterToken: json['twitterToken'] as String,
      twitterTokenSecret: json['twitterTokenSecret'] as String,
      telegramApiKey: json['telegramApiKey'] as String,
    );
  }

  static SecretService _flavorService;
  static SecretService get flavorService {
    if (_flavorService != null) return _flavorService;
    _flavorService = SecretService.fromJson(environment);
    return _flavorService;
  }
}
