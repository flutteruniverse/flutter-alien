class GithubRepository {
  final String title;
  final String link;
  final List<Release> releases;

  GithubRepository({
    this.title,
    this.link,
    this.releases,
  });
}

class Release {
  final String updated;
  final String version;
  final String link;
  final String content;

  Release({
    this.updated,
    this.version,
    this.link,
    this.content,
  });
}
