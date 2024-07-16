import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _fCMToken;

  @override
  void initState() {
    super.initState();
    _initPushNotification();
  }

  Future<void> _initPushNotification() async {
    final fCMToken = await FirebaseMessaging.instance.getToken();
    setState(() {
      _fCMToken = fCMToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Push Notifications'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('FCM Token: $_fCMToken'),
          ],
        ),
      ),
    );
  }
}
