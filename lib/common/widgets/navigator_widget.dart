
import 'package:flutter/material.dart';
/// NavigatorWidget is wrapper around the `Navigator` 
/// which gives from you a `GlobalKey` with the`NavigatorState` type and 
/// also a widget called `screen` in order to wrap your widget with `navigator` 
class NavigatorWidget extends StatelessWidget {
  const NavigatorWidget(
      {super.key, required this.navigatorKey, required this.screen});
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget screen;
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (setting) => MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }
}