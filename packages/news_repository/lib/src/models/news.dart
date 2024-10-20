import 'package:news_repository/src/entities/news_entity.dart';

class News {
  final String author;
  final String title;
  final String description;
  final String urlToImage;
  final String url;
  final String publishedAt;
  bool? isBookmarked = false;

  News(
      {required this.author,
      required this.title,
      required this.description,
      required this.urlToImage,
      required this.url,
      this.isBookmarked,
      required this.publishedAt});
  static var empty = NewsEntity(
    author: 'Unknown Author',
    title: 'No Title',
    description: 'No Description',
    url: '',
    isBookmarked: false,
    urlToImage: 'assets/images/pexels-luis-gomes-166706-546819.jpg',
    publishedAt: 'Unknown Date',
  );

  News copywWith({
    String? author,
    String? title,
    String? description,
    String? urlToImage,
    String? url,
    String? publishedAt,
    bool? isBookmarked,
  }) {
    return News(
      author: author ?? this.author,
      title: title ?? this.title,
      description: description ?? this.description,
      urlToImage: urlToImage ?? this.urlToImage,
      url: url ?? this.url,
      publishedAt: publishedAt ?? this.publishedAt,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }

  bool get isEmpty => this == News.empty;
  bool get isNotEmpty => this != News.empty;

  NewsEntity toEntity() {
    return NewsEntity(
      author: author,
      title: title,
      description: description,
      urlToImage: urlToImage,
      url: url,
      publishedAt: publishedAt,
      isBookmarked: isBookmarked,
    );
  }

  static News fromEntity(NewsEntity entity) {
    return News(
      author: entity.author,
      title: entity.title,
      description: entity.description,
      urlToImage: entity.urlToImage,
      url: entity.url,
      publishedAt: entity.publishedAt,
      isBookmarked: entity.isBookmarked,
    );
  }
}
