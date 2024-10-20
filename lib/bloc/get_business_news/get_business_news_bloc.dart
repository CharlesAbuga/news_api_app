import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_repository/news_repository.dart';

part 'get_business_news_event.dart';
part 'get_business_news_state.dart';

class GetBusinessNewsBloc
    extends Bloc<GetBusinessNewsEvent, GetBusinessNewsState> {
  final NewsRepository _newsRepository;
  GetBusinessNewsBloc({required NewsRepository newsRepository})
      : _newsRepository = newsRepository,
        super(GetBusinessNewsInitial()) {
    on<GetBusinessNews>((event, emit) async {
      try {
        emit(GetBusinessNewsLoading());
        final news = await _newsRepository.getBusinessNews();
        emit(GetBusinessNewsSuccess(news));
      } catch (e) {
        log(e.toString());
        emit(GetBusinessNewsFailure('Failed to load news'));
      }
    });
  }
}
