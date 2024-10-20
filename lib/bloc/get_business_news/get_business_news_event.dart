part of 'get_business_news_bloc.dart';

abstract class GetBusinessNewsEvent extends Equatable {
  const GetBusinessNewsEvent();

  @override
  List<Object> get props => [];
}

class GetBusinessNews extends GetBusinessNewsEvent {
  const GetBusinessNews();
}
