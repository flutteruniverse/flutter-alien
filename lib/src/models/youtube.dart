class YoutubeChannel {
  final String title;
  final String link;
  final List<YoutubePost> youtubePosts;

  YoutubeChannel({
    this.title,
    this.link,
    this.youtubePosts,
  });
}

class YoutubePost {
  final String pubDate;
  final String title;
  final String link;

  YoutubePost({
    this.pubDate,
    this.title,
    this.link,
  });
}
