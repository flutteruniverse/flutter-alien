/// Youtube channel model
class YoutubeChannel {
  /// Title of Youtube channel
  final String title;

  /// Link of Youtube channel
  final String link;

  /// Videos post from Youtube channel
  final List<YoutubePost> youtubePosts;

  /// Youtube channel constructor
  YoutubeChannel({
    this.title,
    this.link,
    this.youtubePosts,
  });
}

/// Youtube post model
class YoutubePost {
  /// Publication date of Youtube video post
  final DateTime pubDate;

  /// Title of Youtube video post
  final String title;

  /// Link of Youtube video post
  final String link;

  /// Youtube post constructor
  YoutubePost({
    this.pubDate,
    this.title,
    this.link,
  });
}
