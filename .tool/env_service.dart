import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  final config = <String, String>{
    'spotifyClientId': Platform.environment['SPOTIFY_ID'],
    'spotifyClientSecret': Platform.environment['SPOTIFY_SECRET'],
    'twitterApiKey': Platform.environment['TWITTER_API_KEY'],
    'twitterSecretKey': Platform.environment['TWITTER_SECRET_KEY'],
    'twitterToken': Platform.environment['TWITTER_TOKEN'],
    'twitterTokenSecret': Platform.environment['TWITTER_TOKEN_SECRET'],
    'telegramApiKey': Platform.environment['TELEGRAM_API_KEY']
  };

  final filename = 'lib/config/env.dart';
  await File(filename).writeAsString(
      'const Map<String, String> environment = <String, String>${json.encode(config)};');
}
