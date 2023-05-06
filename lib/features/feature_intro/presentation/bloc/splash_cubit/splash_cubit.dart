import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/foundation.dart';
import 'package:news_reader/common/utils/pref_opreator.dart';
import 'package:news_reader/features/feature_intro/presentation/bloc/states/intro_state.dart';
import 'package:news_reader/features/feature_intro/repositories/spalsh_repository.dart';
part 'splash_state.dart';
part '../states/connection_status.dart';

class SplashCubit extends Cubit<SplashState> {
  final SplashRepository _splashRepository;
  final PrefOperator _prefOperator;
  SplashCubit(
      {required SplashRepository splashRepository,
      required PrefOperator prefOperator})
      : _splashRepository = splashRepository,
        _prefOperator = prefOperator,
        super(SplashState(
            connectionStatus: ConnectionInitial(),
            introState: IntroState.initial));

  /// checks if user connected to internet and the intro has shown or not
  /// if connected to internet the connectionState would be `ConnectionOn` or not
  /// would `ConnectionOff` , for intro the `shown` mean we had show the user intro
  /// and the `notShown` mean we hadn't did it !
  void checkConnectivity() async {
    await Future.delayed(Duration(milliseconds: 800));
    await _splashRepository.checkConnectivity().then((bool isConnected) async {
      if (isConnected) {
        // checks for intro state
        await _prefOperator.getIntroScreen().then((bool hasShown) {
          if (hasShown) {
            emit(state.copyWith(
                newConnectionStatus: ConnectionOn(),
                newIntroState: IntroState.shown));
          } else {
            emit(state.copyWith(
                newConnectionStatus: ConnectionOn(),
                newIntroState: IntroState.notShown));
          }
        });
      } else {
        emit(
          state.copyWith(
              newConnectionStatus: ConnectionOff(),
              newIntroState: IntroState.initial),
        );
      }
    });
  }
}
