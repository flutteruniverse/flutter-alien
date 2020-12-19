import 'dart:core';

import 'package:dart_rss/domain/media/media.dart';
import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

/// Youtube feed model
class YoutubeFeed {
  /// Title of Youtube feed
  final String title;

  /// Author of Youtube feed
  final String author;

  /// Description of Youtube feed
  final String description;

  /// Link of Youtube feed
  final String link;

  /// List of Youtube feed videos
  final List<YoutubeVideo> videos;

  /// Last update date of Youtube feed
  final String lastBuildDate;

  /// Youtube feed constructor
  YoutubeFeed({
    this.title,
    this.author,
    this.description,
    this.link,
    this.videos,
    this.lastBuildDate,
  });

  /// Parsing Youtube xml [element]
  factory YoutubeFeed.parse(String xmlString) {
    final document = XmlDocument.parse(xmlString);
    XmlElement channelElement;
    try {
      channelElement = document.findAllElements('feed').first;
    } on Exception catch (e) {
      throw ArgumentError('channel not found: $e');
    }

    /// Parsing Youtube feed from xml [element]
    return YoutubeFeed(
      title: findElementOrNull(channelElement, 'title')?.text,
      author: findElementOrNull(channelElement, 'author')?.text,
      link: findElementOrNull(channelElement, 'link')?.getAttribute('href'),
      videos: channelElement.findElements('entry').map((element) {
        return YoutubeVideo.parse(element);
      }).toList(),
      lastBuildDate: findElementOrNull(channelElement, 'lastBuildDate')?.text,
    );
  }
}

/// Youtube video model
class YoutubeVideo {
  /// Title of Youtube video
  final String title;

  /// Description of Youtube video
  final String description;

  /// Link of Youtube video
  final String link;

  /// Publication date of Youtube video
  final String pubDate;

  /// Author of Youtube video
  final String author;

  /// Media info of Youtube video
  final Media media;

  /// Youtube video constructor
  YoutubeVideo({
    this.title,
    this.description,
    this.link,
    this.pubDate,
    this.author,
    this.media,
  });

  /// Parsing Youtube item from xml [element]
  factory YoutubeVideo.parse(XmlElement element) {
    return YoutubeVideo(
      title: findElementOrNull(element, 'title')?.text,
      description: findElementOrNull(element, 'description')?.text,
      link: findElementOrNull(element, 'link')?.getAttribute('href'),
      pubDate: findElementOrNull(element, 'pubDate')?.text,
      author: findElementOrNull(element, 'author')?.text,
      media: Media.parse(element),
    );
  }
}
