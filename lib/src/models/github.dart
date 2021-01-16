/// Github repository model
class GithubRepository {
  /// Title of Github repository
  final String title;

  /// Link of Github repository
  final String link;

  /// Releases list from Github repository
  final List<Release> releases;

  /// Github repository constructor
  GithubRepository({
    this.title,
    this.link,
    this.releases,
  });
}

/// Release model
class Release {
  /// Updated date of Release
  final DateTime updated;

  /// Version number of Release
  final String version;

  /// Link of Release
  final String link;

  /// Content of Release
  final String content;

  /// Release constructor
  Release({
    this.updated,
    this.version,
    this.link,
    this.content,
  });
}
