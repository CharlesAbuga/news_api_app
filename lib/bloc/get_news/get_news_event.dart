part of 'get_news_bloc.dart';

@immutable
abstract class GetNewsEvent extends Equatable {
  const GetNewsEvent();

  @override
  List<Object> get props => [];
}

class GetNews extends GetNewsEvent {
  const GetNews();
}
