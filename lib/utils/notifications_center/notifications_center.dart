import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsCenter {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static Future<void> initialize() async {
    final permission = await FirebaseMessaging.instance.requestPermission();
    if (permission.alert == AppleNotificationSetting.enabled) {
      print(true);
    }
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('mipmap/notification_icon_foreground');
    var iosInitializationSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (
        id,
        title,
        body,
        payload,
      ) async {},
    );
    var initializeSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializeSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        print('Sent');
      },
    );
    await FirebaseMessaging.instance.getAPNSToken();
    await FirebaseMessaging.instance.subscribeToTopic('tips');
    await FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen(showNotification);
    FirebaseMessaging.onBackgroundMessage(showNotification);
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      showNotification(event);
    });
  }

  static NotificationDetails notificationDetails() {
    print('details');
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId',
        'channelName',
        importance: Importance.max,
        priority: Priority.max,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        interruptionLevel: InterruptionLevel.active,
      ),
    );
  }

  static Future showNotification(RemoteMessage message) {
    print("show notification");
    return flutterLocalNotificationsPlugin.show(
      500,
      message.notification!.title,
      message.notification!.body,
      notificationDetails(),
    );
  }
}
