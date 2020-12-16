import 'package:dart_rss/dart_rss.dart';

import '../config/env.dart';
import '../models/index.dart';
import '../models/youtube_parse.dart';
import './http_service.dart';
import './secret_service.dart';

abstract class SocialServiceInterface {
  void init();
  Future<MediumChannel> getMediumFeed(String feedUrl);
  Future<YoutubeChannel> getYoutubeFeed(String feedUrl);
  Future<void> getGithubReleases(String onwer, String repository);
}

class SocialService implements SocialServiceInterface {
  SocialService._();

  static SocialService _instance;
  static SocialService get instance {
    _instance ??= SocialService._();
    return _instance;
  }

  final httpClient = HttpService();
  final secretService = SecretService.fromJson(environment);

  @override
  void init() {
    httpClient.initClient();
  }

  @override
  Future<GithubRepository> getGithubReleases(
      String owner, String repository) async {
    final response = await httpClient
        .getData('https://github.com/$owner/$repository/releases.atom');
    final githubReleases = AtomFeed.parse(response.body);

    return GithubRepository(
      title: githubReleases.title,
      link: githubReleases.links.first.href,
      releases: githubReleases.items
          .map(
            (AtomItem e) => Release(
              link: e.links.first.href,
              updated: e.updated,
              version: e.title,
              content: e.content,
            ),
          )
          .toList(),
    );
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
