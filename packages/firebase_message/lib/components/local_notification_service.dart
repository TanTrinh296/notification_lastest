part of '../firebase_message.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final LocalNotificationService _localNotificationService =
      LocalNotificationService._internal();

  factory LocalNotificationService() {
    return _localNotificationService;
  }
  LocalNotificationService._internal();

  void init(Function onSelectNotification) {
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));

    _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      onSelectNotification;
    });
  }

  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails("My_app", "My_app channel",
              importance: Importance.high, priority: Priority.high));
      await _notificationsPlugin.show(id, message.notification!.title,
          message.notification!.body, notificationDetails,
          payload: "");
    } on Exception catch (e) {
      print(e);
    }
  }
}
