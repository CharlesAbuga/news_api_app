part of 'get_business_news_bloc.dart';

sealed class GetBusinessNewsState extends Equatable {
  const GetBusinessNewsState();

  @override
  List<Object> get props => [];
}

final class GetBusinessNewsInitial extends GetBusinessNewsState {}

final class GetBusinessNewsLoading extends GetBusinessNewsState {}

final class GetBusinessNewsSuccess extends GetBusinessNewsState {
  final List<News> news;

  const GetBusinessNewsSuccess(this.news);

  @override
  List<Object> get props => [news];
}

final class GetBusinessNewsFailure extends GetBusinessNewsState {
  final String message;

  const GetBusinessNewsFailure(this.message);

  @override
  List<Object> get props => [message];
}
