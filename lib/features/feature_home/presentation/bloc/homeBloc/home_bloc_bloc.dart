import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:news_reader/common/resources/data_state.dart';
import 'package:news_reader/common/utils/pref_opreator.dart';
import 'package:news_reader/features/feature_home/data/models/topHeadLine_model/top_head_line_modle.dart';
import 'package:news_reader/features/feature_home/presentation/bloc/home_data_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_reader/features/feature_home/repositories/home_repository.dart';
part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  final HomeNewsRepository _newsRepository;
  final PrefOperator _prefOperator;
  HomeBloc(
      {required HomeNewsRepository newsRepository,
      required PrefOperator prefOperator})
      : _newsRepository = newsRepository,
        _prefOperator = prefOperator,
        super(
          HomeBlocState(
            headlineDataState: HomeDataInitialState(),
            topicNewsDataState: HomeDataInitialState(),
          ),
        ) {
    on<HomeLoadHeadlineNewsEvent>(_loadHeadLineNewsEvent);
    on<HomeLoadTopicNewsEvent>(_loadTopicNewsEvent);
  }

  Future<void> _loadHeadLineNewsEvent(
    HomeLoadHeadlineNewsEvent event,
    Emitter<HomeBlocState> emit,
  ) async {
    /// emits loading state
    emit(state.copyWith(newHeadLineState: HomeDataLoadingState()));
    // fetch the data
    DataState<List<NewsModel>> headlineNews =
        await _newsRepository.fetchHeadLineNews();
    if (headlineNews is DataSuccess) {
      emit(state.copyWith(
          newHeadLineState: HomeDataLoadedState(data: headlineNews)));
    } else {
      emit(state.copyWith(
          newHeadLineState: HomeDataErrorState(error: headlineNews.error!)));
    }
  }

  Future<void> _loadTopicNewsEvent(
    HomeLoadTopicNewsEvent event,
    Emitter<HomeBlocState> emit,
  ) async {
    emit(state.copyWith(newTopicDataState: HomeDataLoadingState()));
    DataState<List<NewsModel>> topicData =
        await _newsRepository.getNewsBaseOnTopic(event.topic);
    if (topicData is DataSuccess) {
      emit(state.copyWith(
          newTopicDataState: HomeDataLoadedState(data: topicData.data)));
    } else {
      emit(state.copyWith(
          newTopicDataState: HomeDataErrorState(error: topicData.error!)));
      
    }
  }
}
