import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_reader/common/resources/data_state.dart';
import 'package:news_reader/features/feature_home/presentation/bloc/home_data_status.dart';
import 'package:news_reader/features/feature_home/repositories/home_repository.dart';

class HeadLineCubit extends Cubit<HomeDataState> {
  final HomeNewsRepository _homeNewsRepository;
  HeadLineCubit({required HomeNewsRepository homeNewsRepository})
      : _homeNewsRepository = homeNewsRepository,
        super(
          HomeDataInitialState(),
        );

  /// fetch headline news from repository
  fetchHeadLineNews() async {
    /// emits the loading state
    emit(
      HomeDataLoadingState(),
    );

    /// req to server to get headlines
    final headLineResponse = await _homeNewsRepository.fetchHeadLineNews();

    /// if response is DataSuccess so we emit `List<NewsModel>` to UI
    if (headLineResponse is DataSuccess) {
      emit(
        HomeDataLoadedState(
          data: headLineResponse.data,
        ),
      );
    }

    /// else we emit the error to UI
    else {
      emit(
        HomeDataErrorState(
          error: headLineResponse.error!,
        ),
      );
    }
  }
}
