part of 'get_tech_news_bloc.dart';

abstract class GetTechNewsState extends Equatable {
  const GetTechNewsState();

  @override
  List<Object> get props => [];
}

final class GetTechNewsInitial extends GetTechNewsState {}

final class GetTechNewsLoading extends GetTechNewsState {}

final class GetTechNewsSuccess extends GetTechNewsState {
  final List<News> news;

  const GetTechNewsSuccess(this.news);

  @override
  List<Object> get props => [news];
}

final class GetTechNewsFailure extends GetTechNewsState {
  final String message;

  const GetTechNewsFailure(this.message);

  @override
  List<Object> get props => [message];
}
