import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_reader/common/widgets/bottom_navigation_widget.dart';
import 'package:news_reader/common/widgets/navigator_widget.dart';
import 'package:news_reader/features/feature_bookmark/presentation/screens/book_mark_screen.dart';
import 'package:news_reader/features/feature_explore/presentaion/screens/explore_scree.dart';
import 'package:news_reader/features/feature_home/presentation/screens/home_screen.dart';
import 'package:news_reader/features/feature_settings/presentation/screens/setting_screen.dart';

class BottomNavIndex {
  BottomNavIndex._();
  static const int homeIndex = 0;
  static const int exploreIndex = 1;
  static const int bookMarkIndex = 2;
  static const int settingIndex = 3;
}

class MainScreen extends StatefulWidget {
  static const String routeName = '/main_screen';

  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  /// navigation keys !
  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _exploreKey = GlobalKey();
  final GlobalKey<NavigatorState> _bookMarkKey = GlobalKey();
  final GlobalKey<NavigatorState> _settingsKey = GlobalKey();

  /// navigation key mapper in order to have better selection of key and less boiler plate
  /// with the `selected index` which is from cubit we will access the `current state` of each key then
  /// we could perform for navigation staff
  late final navigationMapper = {
    BottomNavIndex.homeIndex: _homeKey,
    BottomNavIndex.exploreIndex: _exploreKey,
    BottomNavIndex.bookMarkIndex: _bookMarkKey,
    BottomNavIndex.settingIndex: _settingsKey
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationWidget(
        btnItems: [
          BtnItem(
            enabled: true,
            icon: CupertinoIcons.house,
            onTap: () {},
            text: 'Home',
          ),
          BtnItem(
            enabled: false,
            icon: CupertinoIcons.compass,
            onTap: () {},
            text: 'Explore',
          ),
          BtnItem(
            enabled: false,
            icon: CupertinoIcons.bookmark,
            onTap: () {},
            text: 'Bookmark',
          ),
          BtnItem(
            enabled: false,
            icon: CupertinoIcons.settings,
            onTap: () {},
            text: 'Settings',
          ),
        ],
        size: MediaQuery.of(context).size,
      ),
      body: IndexedStack(
        index: BottomNavIndex.homeIndex,
        children: [
          NavigatorWidget(
            navigatorKey: _homeKey,
            screen: const HomeScreen(),
          ),
          NavigatorWidget(
            navigatorKey: _exploreKey,
            screen: const ExploreScreen(),
          ),
          NavigatorWidget(
            navigatorKey: _bookMarkKey,
            screen: const BookMarkScreen(),
          ),
          NavigatorWidget(
            navigatorKey: _settingsKey,
            screen: const SettingScreen(),
          )
        ],
      ),
    );
  }
}
