part of '../firebase_message.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }
  NotificationService._internal();

  Future<void> initFirebase() async {
    await Firebase.initializeApp();
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  showNotification(RemoteMessage message) {
    LocalNotificationService.display(message);
  }

  onBackgroundMessage(Future<void> Function(RemoteMessage) handler) {
    FirebaseMessaging.onBackgroundMessage(handler);
  }

  onTerninateMessage(Function options) {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.getInitialMessage().then((message) {
      if (message?.notification != null) {
        options;
      }
    });
  }

  onForegroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        LocalNotificationService.display(message);
      }
    });
  }

  onTappedMessage(Function onTaped) {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      onTaped;
    });
  }
}
