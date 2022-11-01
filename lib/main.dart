
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fue_got_talent/layout/social_app/cubit/cubit.dart';
import 'package:fue_got_talent/layout/social_app/social_layout.dart';
import 'package:fue_got_talent/modules/social_app/social_login/cubit/states.dart';
import 'package:fue_got_talent/modules/social_app/social_login/social_login_screen.dart';
import 'package:fue_got_talent/shared/bloc_observer.dart';
import 'package:fue_got_talent/shared/components/components.dart';
import 'package:fue_got_talent/shared/components/constants.dart';
import 'package:fue_got_talent/shared/helper_functions.dart';
import 'package:fue_got_talent/shared/network/local/cache_helper.dart';
import 'package:fue_got_talent/shared/network/remote/dio_helper.dart';
import 'package:fue_got_talent/shared/styles/themes.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'layout/social_app/cubit/states.dart';

Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage message
    ) async
{
  print("on background message");
  print(message);
  showToast(msg: "on background message", state: ToastStates.SUCCESS);
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  customErrorScreen();
  await Firebase.initializeApp();

  AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      "High Importance Notification",
      description:"This channel is used for important notifications",
      importance: Importance.high,
      playSound:true
  );

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true
  );

  token = await FirebaseMessaging.instance.getToken();
  print('my token $token');

  FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print(message);
    // print(event.notification!.body.toString());
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification?.title,
        notification?.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
              channel.id,
              channel.name,
            channelDescription: channel.description,
            playSound: true,
          ),
        ),
    );
  });
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    print(message);
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification?.title,
      notification?.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          playSound: true,
        ),
      ),
    );

  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);



  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key:'isDark')??false;
  //bool isDark = false;
  late Widget widget;
  // bool? onBoarding = CacheHelper.getData(key:'onBoarding');
  // token = CacheHelper.getData(key:'token');
  uid = CacheHelper.getData(key:'uid');

  // if(onBoarding != null)
  // {
  //   if(token != null)
  //     {
  //       widget = ShopLayout();
  //     }else
  //     {
  //       widget = ShopLoginScreen();
  //     }
  // }else
  // {
  //   widget = onBoadrdingScreen();
  // }
  if (uid != null)
  {
    widget = SocialLayout();
  }else{
    widget = SocialLoginScreen();
  }
  BlocOverrides.runZoned(()async
   {
     runApp(MyApp(
         isDark:isDark,
         startWidget:widget,
     ));
   },
     blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget
{

  final bool isDark;
  final Widget startWidget;

  MyApp({required this.isDark,required this.startWidget});
  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(

      providers: [
        BlocProvider(
          create: (BuildContext context) => SocialCubit()..getUserData(),
        ),
      ],
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {
          if (state is SocialGetUserSuccessState)
          {
            // SocialCubit.get(context).getUser();
            SocialCubit.get(context).getPosts();
            SocialCubit.get(context).getProfilePostsNew();
          }

        },
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: SplashScreenView(

              backgroundColor: Colors.white,
              navigateRoute: startWidget,
              duration: 4000,
              imageSize: 240,
              imageSrc: "assets/images/new.jpg",
            ),
          );
        },
      ),
    );
  }
}
