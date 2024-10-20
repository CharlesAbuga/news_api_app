part of 'get_health_news_bloc.dart';

abstract class GetHealthNewsState extends Equatable {
  const GetHealthNewsState();

  @override
  List<Object> get props => [];
}

final class GetHealthNewsInitial extends GetHealthNewsState {}

final class GetHealthNewsLoading extends GetHealthNewsState {}

final class GetHealthNewsSuccess extends GetHealthNewsState {
  final List<News> news;

  const GetHealthNewsSuccess(this.news);

  @override
  List<Object> get props => [news];
}

final class GetHealthNewsFailure extends GetHealthNewsState {
  final String message;

  const GetHealthNewsFailure(this.message);

  @override
  List<Object> get props => [message];
}
