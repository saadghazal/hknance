import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hknance/main.dart';
import 'package:hknance/screens/main_screens/main_screen.dart';
import 'package:hknance/utils/routing_animation.dart';



class NotificationsCenter{

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
 Future<void> initNotifications()async{
  await _firebaseMessaging.requestPermission();
  final fcmToken = await _firebaseMessaging.getToken();
  print(fcmToken);
  initPushNotifications();
}


 void handleMessage(RemoteMessage? message){
   if(message == null) {
     return;
   } else{
     navigator.currentState!.pushAndRemoveUntil(RoutingAnimation.downToUp(screen: MainScreen()), (route) => false);
   }
 }
 Future initPushNotifications()async{
   _firebaseMessaging.getInitialMessage().then(handleMessage);
   FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

 }
}