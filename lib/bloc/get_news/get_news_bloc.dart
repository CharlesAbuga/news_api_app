import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:news_repository/news_repository.dart';

part 'get_news_event.dart';
part 'get_news_state.dart';

class GetNewsBloc extends Bloc<GetNewsEvent, GetNewsState> {
  final NewsRepository _newsRepository;
  GetNewsBloc({required NewsRepository newsRepository})
      : _newsRepository = newsRepository,
        super(GetNewsInitial()) {
    on<GetNews>((event, emit) async {
      try {
        emit(GetNewsLoading());
        final news = await _newsRepository.getNews();
        emit(GetNewsSuccess(news));
      } catch (e) {
        log(e.toString());
        emit(GetNewsFailure('Failed to load news'));
      }
    });
  }
}
