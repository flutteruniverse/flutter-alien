import 'package:dart_rss/dart_rss.dart';
import 'package:flutter_alien/src/models/youtube_parse.dart';
import 'package:github/github.dart';

import '../models/index.dart';
import './http_service.dart';

abstract class SocialServiceInterface {
  void init();
  Future<MediumChannel> getMediumFeed(String feedUrl);
  Future<YoutubeChannel> getYoutubeFeed(String feedUrl);
  Future<void> getGithubReleases();
}

class SocialService implements SocialServiceInterface {
  SocialService._();

  static SocialService _instance;
  static SocialService get instance {
    _instance ??= SocialService._();
    return _instance;
  }

  final httpClient = HttpService();
  GitHub github;

  @override
  void init() {
    httpClient.initClient();
    github = GitHub(auth: Authentication.anonymous());
  }

  @override
  Future<void> getGithubReleases() async {
    await github.repositories
        .listReleases(RepositorySlug('flutter', 'engine'))
        .toList();
  }

  @override
  Future<MediumChannel> getMediumFeed(String username) async {
    final response =
        await httpClient.getData('https://medium.com/feed/$username');
    final mediumFeed = RssFeed.parse(response.body);

    return MediumChannel(
      title: mediumFeed.title,
      description: mediumFeed.description,
      imageLink: mediumFeed.image.link,
      mediumPosts: mediumFeed.items
          .map<MediumPost>(
            (RssItem e) => MediumPost(
              link: e.link,
              pubDate: e.pubDate,
              title: e.title,
            ),
          )
          .toList(),
    );
  }

  @override
  Future<YoutubeChannel> getYoutubeFeed(String channelId) async {
    final response = await httpClient.getData(
        'https://www.youtube.com/feeds/videos.xml?channel_id=$channelId');
    final youtubeFeed = YoutubeFeed.parse(response.body);
    return YoutubeChannel(
      title: youtubeFeed.title,
      link: youtubeFeed.link,
      youtubePosts: youtubeFeed.items
          .map<YoutubePost>(
            (YoutubeItem e) => YoutubePost(
              link: e.link,
              pubDate: e.pubDate,
              title: e.title,
            ),
          )
          .toList(),
    );
  }
}
