import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:news_reader/common/resources/data_state.dart';
import 'package:news_reader/common/utils/pref_opreator.dart';
import 'package:news_reader/features/feature_home/data/models/headline_model/headline_model.dart';
import 'package:news_reader/features/feature_home/data/models/news_model/news_model.dart';
import 'package:news_reader/features/feature_home/presentation/bloc/home_data_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_reader/features/feature_home/repositories/home_repository.dart';
part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  final HomeNewsRepository _newsRepository;
  final PrefOperator _prefOperator;
  List<String> topics = [];
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
    on<HomeLoadAllFeed>(_loadAllFeed);
    _loadFavList();
  }

  Future<void> _loadHeadLineNewsEvent(
    HomeLoadHeadlineNewsEvent event,
    Emitter<HomeBlocState> emit,
  ) async {
    /// emits loading state
    emit(state.copyWith(newHeadLineState: HomeDataLoadingState()));
    // fetch the data
    DataState<List<HeadLineNewsModel>> headlineNews =
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

  Future<void> _loadAllFeed(
    HomeLoadAllFeed event,
    Emitter<HomeBlocState> emit,
  ) async {
    log('loading home feed..');

    /// emit loading all data
    emit(state.copyWith(
        newHeadLineState: HomeDataLoadingState(),
        newTopicDataState: HomeDataLoadingState()));

    /// fetches the headline news for country
    final headLineResponse = await _newsRepository.fetchHeadLineNews();

    /// gets the first topic from selected list
    String? firstTopic =
        await _prefOperator.getUserTopics().then((value) => value!.first);

    /// gets the news based on the topic
    final firstTopicNews =
        await _newsRepository.getNewsBaseOnTopic(firstTopic!);

    /// if states was success for both
    if (headLineResponse is DataSuccess && firstTopicNews is DataSuccess) {
      emit(state.copyWith(
          newHeadLineState: HomeDataLoadedState(data: headLineResponse.data),
          newTopicDataState: HomeDataLoadedState(data: firstTopicNews.data)));
    }

    /// if the header response was failed emit the state
    if (headLineResponse is DataFailed && firstTopicNews is DataFailed) {
      emit(
        state.copyWith(
          newTopicDataState: HomeDataErrorState(
            error: firstTopicNews.error!,
          ),
          newHeadLineState: HomeDataErrorState(
            error: headLineResponse.error!,
          ),
        ),
      );
    }

    // /// if the topic response was failed emit the error state
    // if (firstTopic is DataFailed) {
    //   emit(state.copyWith(
    //       newTopicDataState: HomeDataErrorState(error: firstTopicNews.error!)));
    // }
  }

  _loadFavList() async {
    ///load all topics from db
    await _prefOperator.getUserTopics().then((List<String>? value) {
      if (value != null) {
        print(value);
        topics = value;
      }
    });
  }
}
