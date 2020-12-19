import 'dart:io';

import 'package:flutter_alien/flutter_alien.dart';

void main(List<String> args) async {
  final socialService = SocialService.instance;
  socialService.init();
  await socialService.getMediumFeed('dartlang').then((value) =>
      print('Last post in Dart Medium: ${value.mediumPosts.first.title}'));
  await socialService.getMediumFeed('flutter').then((value) =>
      print('Last post in Flutter Medium: ${value.mediumPosts.first.title}'));
  await socialService.getYoutubeFeed('UCwXdFgeE9KYzlDdR7TG9cMw').then(
        (value) => print(
            'Last post in Flutter Youtube: ${value.youtubePosts.first.title}'),
      );
  await socialService.getGithubReleases('flutter', 'devtools').then((value) =>
      print('Last Dart Devtools version: ${value.releases.first.version}'));
  await socialService.getGithubReleases('flutter', 'flutter').then((value) =>
      print('Last Flutter version: ${value.releases.first.version}'));

  exit(0);
}
