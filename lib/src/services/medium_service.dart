import 'package:dart_rss/dart_rss.dart';

import '../models/medium.dart';
import './http_service.dart';

class MediumService {
  final httpClient = HttpService();

  void initService() {
    httpClient.initClient();
  }

  Future<MediumChannel> getMediumDartFeed() async {
    final response =
        await httpClient.getData('https://medium.com/feed/dartlang');
    final rssFeed = RssFeed.parse(response.body);

    return MediumChannel(
      title: rssFeed.title,
      description: rssFeed.description,
      imageLink: rssFeed.image.link,
      mediumPosts: rssFeed.items
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

  Future<MediumChannel> getMediumFlutterFeed() async {
    final response =
        await httpClient.getData('https://medium.com/feed/flutter');
    final rssFeed = RssFeed.parse(response.body);

    return MediumChannel(
      title: rssFeed.title,
      description: rssFeed.description,
      imageLink: rssFeed.image.link,
      mediumPosts: rssFeed.items
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
}
