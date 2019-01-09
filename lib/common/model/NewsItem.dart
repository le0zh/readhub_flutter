class NewsItem {
  NewsItem(
      {this.id,
      this.summary,
      this.title,
      this.summaryAuto,
      this.mobileUrl,
      this.siteName,
      this.language,
      this.authorName,
      this.publishDate});

  int id;
  String summary;
  String title;
  String summaryAuto;
  String mobileUrl;
  String siteName;
  String language;
  String authorName;
  String publishDate;

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      id: json['id'],
      title: json['title'],
      summary: json['summary'],
      summaryAuto: json['summaryAuto'],
      mobileUrl: json['mobileUrl'],
      siteName: json['siteName'],
      language: json['language'],
      authorName: json['authorName'],
      publishDate: json['publishDate'],
    );
  }
}
