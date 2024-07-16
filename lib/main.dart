import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_notifications/api/firebase_api.dart';
import 'package:test_notifications/firebase_options.dart';
import 'package:test_notifications/pages/home_page.dart';
import 'package:test_notifications/pages/notifications_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Push Notification',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorKey: navigatorKey,
      home: const HomePage(),
      routes: {NotificationsPage.route: (context) => const NotificationsPage()},
    );
  }
}
