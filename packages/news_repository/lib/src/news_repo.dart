import 'package:news_repository/src/models/news.dart';

abstract class NewsRepository {
  Future<List<News>> getNews();
  Future<List<News>> getTechNews();
  Future<List<News>> getBusinessNews();
  Future<List<News>> getHealthNews();
}
