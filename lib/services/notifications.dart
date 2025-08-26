import 'package:evoln/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotifyManager {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  static final AuthServices _auth = AuthServices();

  static void initialize(BuildContext context) async {
    final InitializationSettings _initializeSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
  _notificationsPlugin.initialize(_initializeSettings, onSelectNotification: (String? route) async {
      if (route != null) {
        Navigator.of(context).pushNamed(route);
      }
    });
  }

  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().microsecondsSinceEpoch;
      final NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          'importantnews',
          'news channel',
          'this channel is for important news',
          importance: Importance.max,
          priority: Priority.high,
        ),
      );
      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['route'],
      );
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> createUserData({required User user}) async {
    final token = await _fcm.getToken();
    return _auth.createUserData(user: user, token: token!);
  }

  Future<void> subscribe() => _fcm.subscribeToTopic('news');
  Future<void> unsubscribe() => _fcm.unsubscribeFromTopic('news');
}
