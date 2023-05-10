import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_reader/common/widgets/bottom_navigation_widget.dart';
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

class MainScreen extends StatelessWidget {
  static const String routeName = '/main_screen';
  const MainScreen({super.key});

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
        children: const [
          HomeScreen(), 
          ExploreScreen(), 
          BookMarkScreen(), 
          SettingScreen()
        ],
      ),
    );
  }
}
