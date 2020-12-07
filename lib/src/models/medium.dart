class MediumChannel {
  final String title;
  final String description;
  final String imageLink;
  final List<MediumPost> mediumPosts;

  MediumChannel({
    this.title,
    this.description,
    this.imageLink,
    this.mediumPosts,
  });
}

class MediumPost {
  final String pubDate;
  final String title;
  final String link;

  MediumPost({
    this.pubDate,
    this.title,
    this.link,
  });
}
