part of 'get_tech_news_bloc.dart';

abstract class GetTechNewsEvent extends Equatable {
  const GetTechNewsEvent();

  @override
  List<Object> get props => [];
}

class GetTechNews extends GetTechNewsEvent {
  const GetTechNews();
}
