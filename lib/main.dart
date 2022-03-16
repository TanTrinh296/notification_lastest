import 'package:flutter/material.dart';
import 'package:notificaltion_lastest/view/home.dart';
import 'package:notificaltion_lastest/view/notification_screen.dart';
import 'package:firebase_message/firebase_message.dart' as message;
import 'package:firebase_messaging/firebase_messaging.dart';

final message.NotificationService notificationService =
    message.NotificationService();

final message.LocalNotificationService localNotificationService =
    message.LocalNotificationService();

Future<void> onHandleMessageBackGround(RemoteMessage message) async {
  await notificationService.initFirebase();
  notificationService.showNotification(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await notificationService.initFirebase();
  notificationService.onBackgroundMessage(onHandleMessageBackGround);
  runApp(const MyApp());
}

class StateManager {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    localNotificationService.init(() {});
    notificationService.onTerninateMessage(() {});
    notificationService.onForegroundMessage();
    notificationService.onTappedMessage(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        key: StateManager.navigatorKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {"notication": (_) => const NotificationScreen()},
        home: const HomeScreen());
  }
}
