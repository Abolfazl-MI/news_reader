part of 'splash_cubit.dart';
@immutable
class SplashState extends Equatable {
  final ConnectionStatus connectionStatus;
  final IntroState introState;
  const SplashState({required this.connectionStatus, required this.introState});

  SplashState copyWith(
      {ConnectionStatus? newConnectionStatus, IntroState? newIntroState}) {
    return SplashState(
      connectionStatus: newConnectionStatus ?? connectionStatus,
      introState: newIntroState ?? introState,
    );
  }
  
  @override
  // TODO: implement props
  List<Object?> get props =>[connectionStatus,introState];
}
