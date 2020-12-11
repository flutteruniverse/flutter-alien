import 'dart:io';

import 'package:flutter_alien/flutter_alien.dart';

void main(List<String> args) async {
  final socialService = SocialService.instance;
  socialService.init();
  await socialService
      .getMediumFeed('dartlang')
      .then((value) => print(value.title));
  await socialService
      .getMediumFeed('flutter')
      .then((value) => print(value.title));
  await socialService
      .getYoutubeFeed('UCwXdFgeE9KYzlDdR7TG9cMw')
      .then((value) => print(value.title));
  await socialService.getGithubReleases();

  exit(0);
}
