abstract class HomeDataState {}

class HomeDataInitialState extends HomeDataState{}

class HomeDataLoadingState extends HomeDataState {}

class HomeDataLoadedState<T> extends HomeDataState {
  final T data;
  HomeDataLoadedState({required this.data});
}

class HomeDataErrorState extends HomeDataState {
  final String error;

  HomeDataErrorState({required this.error});

}
