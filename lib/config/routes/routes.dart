import 'package:evoln/main.dart';
import 'package:evoln/base.dart';
import 'package:evoln/screens/favorites_screen.dart';
import 'package:evoln/screens/login_screen.dart';
import 'package:evoln/screens/notification_screen.dart';
import 'package:evoln/screens/saved_screen.dart';
import 'package:evoln/screens/forget_screen.dart';
import 'package:evoln/screens/settings_screen.dart';
import 'package:evoln/screens/signup_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
        builder: (context) {
          return AuthListener();
        },
      );
    case '/base':
      return MaterialPageRoute(
        builder: (context) {
          return Base();
        },
      );
    case '/login':
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return LoginScreen(initialAnimation: animation);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation.drive(
                Tween(begin: 1.3, end: 1.0).chain(
                  CurveTween(curve: Curves.easeOutCubic),
                ),
              ),
              child: child,
            ),
          );
        },
      );
    case '/signup':
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return SignUpScreen(initialAnimation: animation);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation.drive(
                Tween(begin: 1.3, end: 1.0).chain(
                  CurveTween(curve: Curves.easeOutCubic),
                ),
              ),
              child: child,
            ),
          );
        },
      );
    case '/forget':
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return ForgetScreen(initialAnimation: animation);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation.drive(
                Tween(begin: 1.3, end: 1.0).chain(
                  CurveTween(curve: Curves.easeOutCubic),
                ),
              ),
              child: child,
            ),
          );
        },
      );
    case '/settings':
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return SettingsScreen(initialAnimation: animation);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation.drive(
                Tween(begin: 1.3, end: 1.0).chain(
                  CurveTween(curve: Curves.easeOutCubic),
                ),
              ),
              child: child,
            ),
          );
        },
      );
    case '/notifications':
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return NotificationScreen(initialAnimation: animation);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation.drive(
                Tween(begin: 1.3, end: 1.0).chain(
                  CurveTween(curve: Curves.easeOutCubic),
                ),
              ),
              child: child,
            ),
          );
        },
      );
    case '/saved':
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return SavedScreen(initialAnimation: animation);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation.drive(
                Tween(begin: 1.3, end: 1.0).chain(
                  CurveTween(curve: Curves.easeOutCubic),
                ),
              ),
              child: child,
            ),
          );
        },
      );
    case '/favorites':
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return FavoritesScreen(initialAnimation: animation);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation.drive(
                Tween(begin: 1.3, end: 1.0).chain(
                  CurveTween(curve: Curves.easeOutCubic),
                ),
              ),
              child: child,
            ),
          );
        },
      );
    default:
      throw UnimplementedError('no route for $settings');
  }
}
