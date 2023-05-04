import 'package:news_reader/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefOperator {
  late SharedPreferences _preferences;
  static const _showIntro = 'showIntro';

  PrefOperator() {
    _preferences = locator<SharedPreferences>();
  }

  /// checks if we shown the intro to user or not, true =>shown, false notShow

  Future<bool> getIntroScreen() async {
    return _preferences.getBool(_showIntro) ?? false;
  }

  ///changes the intro shown state
  Future<void> changeIntroState(bool value) async {
    await _preferences.setBool(_showIntro, value);
  }
}
