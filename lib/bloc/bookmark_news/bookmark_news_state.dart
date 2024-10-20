part of 'bookmark_news_bloc.dart';

sealed class BookmarkNewsState extends Equatable {
  const BookmarkNewsState();

  @override
  List<Object> get props => [];
}

final class BookmarkNewsInitial extends BookmarkNewsState {}

final class BookmarkNewsLoading extends BookmarkNewsState {}

final class BookmarkNewsLoaded extends BookmarkNewsState {
  final List<News> bookmarkedNews;

  const BookmarkNewsLoaded(this.bookmarkedNews);

  @override
  List<Object> get props => [bookmarkedNews];
}

final class BookmarkNewsError extends BookmarkNewsState {
  final String message;

  const BookmarkNewsError(this.message);

  @override
  List<Object> get props => [message];
}
