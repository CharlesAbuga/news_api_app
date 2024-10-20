part of 'get_health_news_bloc.dart';

abstract class GetHealthNewsEvent extends Equatable {
  const GetHealthNewsEvent();

  @override
  List<Object> get props => [];
}

final class GetHealthNews extends GetHealthNewsEvent {}
