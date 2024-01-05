import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotification {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> iniNotification() async {
    await _firebaseMessaging.requestPermission();

    final token = await _firebaseMessaging.getToken();

    print('Token: $token');
  }

// NB : We can't test notification on the IOS emulator, we need to use a real device..
// This feature will be tested later
}
