import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app_ui/api_key.dart';
import 'package:news_repository/src/api_key.dart';
import 'package:news_repository/src/entities/news_entity.dart';
import 'package:news_repository/src/models/news.dart';
import 'package:news_repository/src/news_repo.dart';

import 'package:shared_packages/shared_packages.dart';

class ApiNewsRepository implements NewsRepository {
  @override
  Future<List<News>> getNews() async {
    try {
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=us&pageSize=100&apiKey=${ApiKey.apiKey}&q=${SearchBar1.searchController.text}'));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> articles = jsonResponse['articles'];
        return articles
            .map((json) => News.fromEntity(NewsEntity.fromDocument(json)))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    throw Exception('Failed to load news');
  }

  @override
  Future<List<News>> getTechNews() async {
    try {
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=us&category=technology&pageSize=100&apiKey=${ApiKey.apiKey}&q=${SearchBar1.searchController.text}'));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> articles = jsonResponse['articles'];
        return articles
            .map((json) => News.fromEntity(NewsEntity.fromDocument(json)))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    throw Exception('Failed to load news');
  }

  @override
  Future<List<News>> getBusinessNews() async {
    try {
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=us&category=business&pageSize=100&apiKey=${ApiKey.apiKey}&q=${SearchBar1.searchController.text}'));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> articles = jsonResponse['articles'];
        return articles
            .map((json) => News.fromEntity(NewsEntity.fromDocument(json)))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    throw Exception('Failed to load news');
  }

  @override
  Future<List<News>> getHealthNews() async {
    try {
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=us&category=health&pageSize=100&apiKey=${ApiKey.apiKey}&q=${SearchBar1.searchController.text}'));
      if (response.statusCode == 200) {
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> articles = jsonResponse['articles'];
        return articles
            .map((json) => News.fromEntity(NewsEntity.fromDocument(json)))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    throw Exception('Failed to load news');
  }
}
