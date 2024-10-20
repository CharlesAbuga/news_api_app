import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_repository/news_repository.dart';

part 'get_health_news_event.dart';
part 'get_health_news_state.dart';

class GetHealthNewsBloc extends Bloc<GetHealthNewsEvent, GetHealthNewsState> {
  final NewsRepository _newsRepository;
  GetHealthNewsBloc({required NewsRepository newsRepository})
      : _newsRepository = newsRepository,
        super(GetHealthNewsInitial()) {
    on<GetHealthNews>((event, emit) async {
      try {
        emit(GetHealthNewsLoading());
        final news = await _newsRepository.getHealthNews();
        emit(GetHealthNewsSuccess(news));
      } catch (e) {
        log(e.toString());
        emit(const GetHealthNewsFailure('Failed to load news'));
      }
    });
  }
}
