import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:news_repository/news_repository.dart';

part 'get_tech_news_event.dart';
part 'get_tech_news_state.dart';

class GetTechNewsBloc extends Bloc<GetTechNewsEvent, GetTechNewsState> {
  final NewsRepository _newsRepository;
  GetTechNewsBloc({required NewsRepository newsRepository})
      : _newsRepository = newsRepository,
        super(GetTechNewsInitial()) {
    on<GetTechNews>((event, emit) async {
      try {
        emit(GetTechNewsLoading());
        final news = await _newsRepository.getTechNews();
        emit(GetTechNewsSuccess(news));
      } catch (e) {
        log(e.toString());
        emit(GetTechNewsFailure('Failed to load news'));
      }
    });
  }
}
