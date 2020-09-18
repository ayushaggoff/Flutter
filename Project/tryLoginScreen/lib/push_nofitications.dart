import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;
  static final PushNotificationsManager _instance =
    PushNotificationsManager._();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("Onmessage come from here Message:$message");
        },
        onResume: (Map<String, dynamic> message) async {
          print("Onmresume come from here :$message");
        },
        onLaunch: (Map<String, dynamic> message) async {
          print("Onlaunch come from here Message:$message");
        },
      );
      String token = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $token");

      _initialized = true;
    }
  }
}
