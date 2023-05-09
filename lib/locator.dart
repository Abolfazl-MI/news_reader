import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_reader/api_constants.dart';
import 'package:news_reader/common/utils/pref_opreator.dart';
import 'package:news_reader/features/feature_home/data/data_source/news_api_provider.dart';
import 'package:news_reader/features/feature_home/repositories/home_repository.dart';
import 'package:news_reader/features/feature_intro/presentation/bloc/splash_cubit/splash_cubit.dart';
import 'package:news_reader/features/feature_intro/repositories/spalsh_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

Future<void> initLocator() async {
  /// networking lib
  locator.registerSingleton<Dio>(
    Dio(),
  );

  ///SharedPreferences
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferences>(sharedPreferences);
  locator.registerSingleton<PrefOperator>(
    PrefOperator(),
  );

  /// splash repository
  locator.registerSingleton<SplashRepository>(
    SplashRepository(),
  );

  /// home provider
  locator.registerSingleton<NewsApiProvider>(
    NewsApiProvider(
      dio: locator<Dio>(),
    ),
  );

  /// home news repository
  locator.registerSingleton<HomeNewsRepository>(
    HomeNewsRepository(
      newsApiProvider: locator<NewsApiProvider>(),
    ),
  );
}
