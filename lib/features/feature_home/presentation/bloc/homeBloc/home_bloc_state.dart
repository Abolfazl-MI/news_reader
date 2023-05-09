part of 'home_bloc_bloc.dart';

class HomeBlocState extends Equatable {
  final HomeDataState headlineDataState;
  final HomeDataState topicNewsDataState;

  const HomeBlocState({
    required this.headlineDataState,
    required this.topicNewsDataState,
  });

  @override
  List<Object?> get props => [
        headlineDataState,
        topicNewsDataState,
        topicNewsDataState,
      ];

  HomeBlocState copyWith({
    HomeDataState? newHeadLineState,
    HomeDataState? newTopicDataState,
  }) {
    return HomeBlocState(
      headlineDataState: newHeadLineState ?? headlineDataState,
      topicNewsDataState: newTopicDataState ?? topicNewsDataState,
    );
  }

  @override
  String toString() =>
      'HomeBlocState(headlineDataState:$headlineDataState,topicNewsDataState:$topicNewsDataState)';
}
