import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_reader/config/strings.dart';
import 'package:news_reader/features/feature_home/presentation/screens/home_screen.dart';
import 'package:news_reader/features/feature_intro/presentation/bloc/states/intro_state.dart';
import 'package:news_reader/features/feature_intro/presentation/bloc/splash_cubit/splash_cubit.dart';
import 'package:news_reader/features/feature_intro/presentation/screens/intro_screen.dart';
import 'package:news_reader/gen/assets.gen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash_screen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _splashDecision(context);
    Future.delayed(Duration(milliseconds: 500), () {
      context.read<SplashCubit>().checkConnectivity();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state.connectionStatus is ConnectionOff) {
            // user is not connected to internet so we show dialog to him to inform him about
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              _noInternetDialog(context);
            });
          }
          // user is online and he had seen intro before so we navigate to home screen!
          if (state.connectionStatus is ConnectionOn &&
              state.introState == IntroState.shown) {
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          }
          // user is online and he hadn't seen the intro
          if (state.connectionStatus is ConnectionOn &&
              state.introState == IntroState.notShown) {
            Navigator.of(context).pushReplacementNamed(IntroScreen.routeName);
          }
        },
        child: FadeIn(
          duration: const Duration(seconds: 1),
          child: Center(child: SvgPicture.asset(Assets.icons.logo)),
        ),
      ),
    );
  }

  Future<dynamic> _noInternetDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: Text('You are not connected!'),
              content: const Text(youAreNotConnected),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(SplashScreen.routeName);
                  },
                  child: Text(
                    'Try Again',
                  ),
                )
              ],
            ));
  }

  void _splashDecision(context) async {
    await Future.delayed(Duration(milliseconds: 500));
    context.read<SplashCubit>().checkConnectivity();
  }
}
