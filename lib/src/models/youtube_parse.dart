import 'dart:core';

import 'package:dart_rss/domain/media/media.dart';
import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

class YoutubeFeed {
  final String title;
  final String author;
  final String description;
  final String link;
  final List<YoutubeItem> items;
  final String lastBuildDate;

  YoutubeFeed({
    this.title,
    this.author,
    this.description,
    this.link,
    this.items,
    this.lastBuildDate,
  });

  factory YoutubeFeed.parse(String xmlString) {
    var document = XmlDocument.parse(xmlString);
    XmlElement channelElement;
    try {
      channelElement = document.findAllElements('feed').first;
    } on StateError {
      throw ArgumentError('channel not found');
    }

    return YoutubeFeed(
      title: findElementOrNull(channelElement, 'title')?.text,
      author: findElementOrNull(channelElement, 'author')?.text,
      link: findElementOrNull(channelElement, 'link')?.getAttribute('href'),
      items: channelElement.findElements('entry').map((element) {
        return YoutubeItem.parse(element);
      }).toList(),
      lastBuildDate: findElementOrNull(channelElement, 'lastBuildDate')?.text,
    );
  }
}

class YoutubeItem {
  final String title;
  final String description;
  final String link;

  final String pubDate;
  final String author;
  final Media media;

  YoutubeItem({
    this.title,
    this.description,
    this.link,
    this.pubDate,
    this.author,
    this.media,
  });

  factory YoutubeItem.parse(XmlElement element) {
    return YoutubeItem(
      title: findElementOrNull(element, 'title')?.text,
      description: findElementOrNull(element, 'description')?.text,
      link: findElementOrNull(element, 'link')?.getAttribute('href'),
      pubDate: findElementOrNull(element, 'pubDate')?.text,
      author: findElementOrNull(element, 'author')?.text,
      media: Media.parse(element),
    );
  }
}
