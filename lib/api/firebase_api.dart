import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:test_notifications/main.dart';
import 'package:test_notifications/pages/notifications_page.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<String> getFCMToken() async {
    return await _firebaseMessaging.getToken() ?? '';
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    getFCMToken().then((token) {
      navigatorKey.currentState?.pushNamed(
        NotificationsPage.route,
        arguments: {
          'message': message,
          'fCMToken': token,
        },
      );
    });
  }

  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('Token: $fCMToken');
    initPushNotification();
  }
}
