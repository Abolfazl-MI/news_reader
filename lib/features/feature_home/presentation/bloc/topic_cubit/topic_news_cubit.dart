import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:news_reader/common/resources/data_state.dart';
import 'package:news_reader/common/utils/pref_opreator.dart';
import 'package:news_reader/features/feature_home/presentation/bloc/home_data_status.dart';
import 'package:news_reader/features/feature_home/repositories/home_repository.dart';

class TopicCubitState extends Equatable {
  final int selectedIndex;
  final HomeDataState topicDataSate;

  const TopicCubitState(
      {required this.selectedIndex, required this.topicDataSate});

  copyWith({int? newSelectedIndex, HomeDataState? newTopicDataState}) {
    return TopicCubitState(
      selectedIndex: newSelectedIndex ?? selectedIndex,
      topicDataSate: newTopicDataState ?? topicDataSate,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, topicDataSate];
}

class TopicCubit extends Cubit<TopicCubitState> {
  List<String> userTopic = [];
  final PrefOperator _prefOperator;
  final HomeNewsRepository _homeNewsRepository;
  TopicCubit(
      {required PrefOperator prefOperator,
      required HomeNewsRepository homeNewsRepository})
      : _homeNewsRepository = homeNewsRepository,
        _prefOperator = prefOperator,
        super(
          TopicCubitState(
              selectedIndex: 0, topicDataSate: HomeDataInitialState()),
        );

  /// fetches the topic base on selected tab
  void fetchTopicNews(String topic) async {
    emit(state.copyWith(newTopicDataState: HomeDataLoadingState()));
    final topicResponse = await _homeNewsRepository.getNewsBaseOnTopic(topic);
    if (topicResponse is DataSuccess) {
      emit(state.copyWith(
          newTopicDataState: HomeDataLoadedState(data: topicResponse.data)));
    } else {
      emit(state.copyWith(
          newTopicDataState: HomeDataErrorState(
        error: topicResponse.error!,
      )));
    }
  }

  /// for initial fetch use, when app load it select the first topic and fetch data base on
  void fetchInitialTopic() async {
    emit(state.copyWith(
        newTopicDataState: HomeDataLoadingState(), newSelectedIndex: 0));

    /// gets the user interest topic from shared preference
    final List<String>? topics = await _prefOperator.getUserTopics();

    /// sets the value to userTopic list for later access
    userTopic = topics ?? [];
    log('User Topics => ${userTopic.toString()}');

    /// first user topic in list
    final String firstTopic = topics?.first ?? 'Car';

    ///fetch the news base on the firstTopic
    final response = await _homeNewsRepository.getNewsBaseOnTopic(firstTopic);
    if (response is DataSuccess) {
      emit(state.copyWith(
          newTopicDataState: HomeDataLoadedState(data: response.data)));
    } else {
      emit(state.copyWith(
          newTopicDataState: HomeDataErrorState(error: response.error!)));
    }
  }

  void updateIndex(int newIndex) {
    emit(state.copyWith(newSelectedIndex: newIndex));
  }
}
