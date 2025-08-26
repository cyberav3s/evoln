import 'package:evoln/config/theme/theme_preferences.dart';
import 'package:evoln/utils/constants.dart';
import 'package:flutter/material.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }
}

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: isDarkTheme ? kDarkBackgroundColor : kBackgroundColor,
      backgroundColor: isDarkTheme ? kDarkBackgroundColor : kBackgroundColor,
      primaryColor: isDarkTheme ? kDarkBackgroundColor : kBackgroundColor,
      cardColor: isDarkTheme ? kCardColor : Color(0xFFF1F5F9),
      buttonColor: isDarkTheme ? kButtonColor : Color(0xFFF1F5F9),
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      appBarTheme: AppBarTheme(
        backgroundColor: isDarkTheme ? Color(0xFF282828) : kBackgroundColor,
        foregroundColor: isDarkTheme ? kDarkBackgroundColor : kBackgroundColor,
        iconTheme: IconThemeData(
          color: isDarkTheme ? Color(0xFFFFFFFF) : kIconColor,
        ),
      ),
    );
  }
}
