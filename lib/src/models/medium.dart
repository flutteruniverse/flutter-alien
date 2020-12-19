/// Medium channel model
class MediumChannel {
  /// Title of Medium
  final String title;

  /// Description of Medium
  final String description;

  /// Image link of Medium
  final String imageLink;

  /// Articles posts from Medium
  final List<MediumPost> mediumPosts;

  /// Medium channel constructor
  MediumChannel({
    this.title,
    this.description,
    this.imageLink,
    this.mediumPosts,
  });
}

/// Medium post model
class MediumPost {
  /// Publication date of Medium article post
  final String pubDate;

  /// Title of Medium video post
  final String title;

  /// Link of Medium video post
  final String link;

  /// Medium post constructor
  MediumPost({
    this.pubDate,
    this.title,
    this.link,
  });
}
