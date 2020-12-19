import 'package:dart_rss/dart_rss.dart';

import '../models/index.dart';
import '../models/youtube_parse.dart';
import './http_service.dart';

/// Social service interface
abstract class SocialServiceInterface {
  /// Init services and others things to social service works
  void init();

  /// Get articles list with info about them.
  /// Required [username]
  Future<MediumChannel> getMediumFeed(String username);

  /// Get Youtube videos list with info about them.
  /// Required Youtube [channelId]
  Future<YoutubeChannel> getYoutubeFeed(String username);

  /// Get release list with info from Github.
  /// Required [onwer] and [repository]
  Future<void> getGithubReleases(String onwer, String repository);
}

/// Social service implementation.
/// Get info about some social media, like Medium, Youtube and Github,
/// using rss links
class SocialService implements SocialServiceInterface {
  SocialService._();

  static SocialService _instance;

  /// Get single instance to Social service
  static SocialService get instance {
    _instance ??= SocialService._();
    return _instance;
  }

  final _httpService = HttpService();

  @override
  void init() {
    _httpService.initClient();
  }

  @override
  Future<GithubRepository> getGithubReleases(
      String owner, String repository) async {
    final response = await _httpService
        .getData('https://github.com/$owner/$repository/releases.atom');
    final githubReleases = AtomFeed.parse(response.body);

    return GithubRepository(
      title: githubReleases.title,
      link: githubReleases.links.first.href,
      releases: githubReleases.items
          .map(
            (e) => Release(
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
        await _httpService.getData('https://medium.com/feed/$username');
    final mediumFeed = RssFeed.parse(response.body);

    return MediumChannel(
      title: mediumFeed.title,
      description: mediumFeed.description,
      imageLink: mediumFeed.image.url,
      mediumPosts: mediumFeed.items
          .map<MediumPost>(
            (e) => MediumPost(
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
    final response = await _httpService.getData(
        'https://www.youtube.com/feeds/videos.xml?channel_id=$channelId');
    final youtubeFeed = YoutubeFeed.parse(response.body);
    return YoutubeChannel(
      title: youtubeFeed.title,
      link: youtubeFeed.link,
      youtubePosts: youtubeFeed.videos
          .map<YoutubePost>(
            (e) => YoutubePost(
              link: e.link,
              pubDate: e.pubDate,
              title: e.title,
            ),
          )
          .toList(),
    );
  }
}
