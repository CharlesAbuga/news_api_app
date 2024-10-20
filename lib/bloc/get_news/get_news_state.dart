part of 'get_news_bloc.dart';

@immutable
sealed class GetNewsState {}

final class GetNewsInitial extends GetNewsState {}

final class GetNewsLoading extends GetNewsState {}

final class GetNewsSuccess extends GetNewsState {
  final List<News> news;

  GetNewsSuccess(this.news);
}

final class GetNewsFailure extends GetNewsState {
  final String message;

  GetNewsFailure(this.message);
}
