part of 'bookmark_news_bloc.dart';

abstract class BookmarkNewsEvent extends Equatable {
  const BookmarkNewsEvent();

  @override
  List<Object> get props => [];
}

final class AddBookmarkNews extends BookmarkNewsEvent {
  final News news;

  const AddBookmarkNews(this.news);

  @override
  List<Object> get props => [news];
}

final class RemoveBookmarkNews extends BookmarkNewsEvent {
  final News news;

  const RemoveBookmarkNews(this.news);

  @override
  List<Object> get props => [news];
}
