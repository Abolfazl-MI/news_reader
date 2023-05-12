part of 'home_bloc_bloc.dart';

abstract class HomeBlocEvent {}

class HomeLoadHeadlineNewsEvent extends HomeBlocEvent {}

class HomeLoadTopicNewsEvent extends HomeBlocEvent {
  final String topic;

  HomeLoadTopicNewsEvent({required this.topic});
}

class HomeLoadAllFeed extends HomeBlocEvent{}