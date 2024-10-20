import 'package:equatable/equatable.dart';

class NewsEntity extends Equatable {
  final String author;
  final String title;
  final String description;
  final String urlToImage;
  final String url;
  final String publishedAt;
  bool? isBookmarked = false;

  NewsEntity(
      {required this.author,
      required this.title,
      required this.description,
      required this.urlToImage,
      required this.url,
      this.isBookmarked,
      required this.publishedAt});

  Map<String, dynamic> toDocument() {
    return {
      'author': author,
      'title': title,
      'description': description,
      'urlToImage': urlToImage,
      'url': url,
      'publishedAt': publishedAt,
      'isBoomarked': isBookmarked,
    };
  }

  static NewsEntity fromDocument(Map<String, dynamic> doc) {
    return NewsEntity(
      author: doc['author'] ?? 'Unknown Author',
      title: doc['title'] ?? 'No Title',
      description: doc['description'] ?? 'No Description',
      urlToImage: doc['urlToImage'] ?? '',
      url: doc['url'] ?? '',
      publishedAt: doc['publishedAt'] ?? '',
      isBookmarked: doc['isBoomarked'] ?? false,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [author, title, description, urlToImage, url, publishedAt, isBookmarked];
}
