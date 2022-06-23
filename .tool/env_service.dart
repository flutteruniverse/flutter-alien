import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  final config = <String, String>{
    'githubToken': Platform.environment['GITHUB_TOKEN'],
  };

  final envName = 'lib/src/config/env.dart';
  await File(envName).writeAsString('''/// Global enviroment variables\n
      const Map<String, String> environment =
      <String, String>${json.encode(config)};''');
}
