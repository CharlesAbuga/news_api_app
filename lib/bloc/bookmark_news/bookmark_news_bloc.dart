import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:news_repository/news_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'bookmark_news_event.dart';
part 'bookmark_news_state.dart';

class BookmarkNewsBloc extends Bloc<BookmarkNewsEvent, BookmarkNewsState> {
  final NewsRepository _newsRepository;
  List<News> bookmarkedNews = [];
  BookmarkNewsBloc({required NewsRepository newsRepository})
      : _newsRepository = newsRepository,
        super(BookmarkNewsInitial()) {
    _loadBookmarkedNews();

    on<AddBookmarkNews>((event, emit) async {
      emit(BookmarkNewsLoading());
      try {
        bookmarkedNews.add(event.news);

        await _saveBookmarkedNews();
        print(event.news.title);
        event.news.isBookmarked = true;
        print(bookmarkedNews.length);
        emit(BookmarkNewsLoaded(List.from(bookmarkedNews)));
      } catch (e) {
        log(e.toString());
        print(e.toString());
      }
    });
    on<RemoveBookmarkNews>((event, emit) async {
      emit(BookmarkNewsLoading());
      try {
        bookmarkedNews.removeWhere((news) => news.title == event.news.title);
        event.news.isBookmarked = false;
        await _saveBookmarkedNews();
        emit(BookmarkNewsLoaded(List.from(bookmarkedNews)));
      } catch (e) {
        log(e.toString());
        emit(BookmarkNewsError(e.toString()));
      }
    });
  }

  Future<void> _loadBookmarkedNews() async {
    final prefs = await SharedPreferences.getInstance();
    final String? bookmarkedNewsString = prefs.getString('bookmarkedNews');
    if (bookmarkedNewsString != null) {
      final List<dynamic> jsonList = jsonDecode(bookmarkedNewsString);
      bookmarkedNews = jsonList
          .map((json) => News.fromEntity(NewsEntity.fromDocument(json)))
          .toList();
      emit(BookmarkNewsLoaded(List.from(bookmarkedNews)));
    }
  }

  Future<void> _saveBookmarkedNews() async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString = jsonEncode(
        bookmarkedNews.map((news) => news.toEntity().toDocument()).toList());
    await prefs.setString('bookmarkedNews', jsonString);
  }

  @override
  Future<void> close() {
    // Perform any cleanup if necessary
    return super.close();
  }
}
