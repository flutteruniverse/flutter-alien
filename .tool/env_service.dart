import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  final config = <String, String>{
    'githubToken': Platform.environment['GITHUB_TOKEN'],
  };

  final filename = 'lib/config/env.dart';
  await File(filename).writeAsString(
      'const Map<String, String> environment = <String, String>${json.encode(config)};');
}
