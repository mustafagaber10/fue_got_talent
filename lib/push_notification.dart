// import 'package:firebase_messaging/firebase_messaging.dart';
//
// class PushNotificationsManager{
//   PushNotificationsManager._();
//   factory PushNotificationsManager()=>_instance;
//   static final PushNotificationsManager _instance=PushNotificationsManager._();
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   bool _initialized = false;
//   Future<void> init() async
//   {
//     if(!_initialized){
//       //ios
//       _firebaseMessaging.requestPermission();
//
//       //android
//       var token = await _firebaseMessaging.getToken();
//       print('my token = $token');
//       _initialized=true;
//     }
//   }
//
// }