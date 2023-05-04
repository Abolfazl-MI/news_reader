import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_reader/common/utils/pref_opreator.dart';
import 'package:news_reader/features/feature_home/presentation/screens/home_screen.dart';
import 'package:news_reader/features/feature_intro/presentation/bloc/splash_cubit/splash_cubit.dart';
import 'package:news_reader/features/feature_intro/presentation/screens/intro_screen.dart';
import 'package:news_reader/features/feature_intro/presentation/screens/splash_screen.dart';
import 'package:news_reader/features/feature_intro/repositories/spalsh_repository.dart';
import 'package:news_reader/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NEws with US',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => BlocProvider(
              create: (_) => SplashCubit(
                splashRepository: locator<SplashRepository>(),
                prefOperator: locator<PrefOperator>(),
              ),
              child: const SplashScreen(),
            ),
        IntroScreen.routeName: (context) => const IntroScreen(),
        HomeScreen.routeName: (context) => const HomeScreen()
      },
    );
  }
}
