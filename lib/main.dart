import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qcec_notify/Auth/Login_Screen.dart';
import 'package:qcec_notify/firebase_options.dart';
import 'package:qcec_notify/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

// إشعارات محلية
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// معالج الإشعارات في الخلفية
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(
    "🔔 رسالة في الخلفية: ${message.notification?.title} - ${message.notification?.body}",
  );
}

Future<void> requestNotificationPermission() async {
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await requestNotificationPermission();

  // إعدادات Android
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  // إعدادات iOS
  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings();

  // الإعدادات الموحدة
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? fcmToken = '';
  String? uid;
  bool isLoading = true;

  Future<void> showNotification(title, body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'high_importance_channel_v2',
          'High Importance Notifications',
          channelDescription:
              'This channel is used for important notifications.',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
          playSound: true,
          sound: RawResourceAndroidNotificationSound("notify"),
        );

    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  Future<void> initFCM() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString("UID");

    NotificationSettings settings = await FirebaseMessaging.instance
        .requestPermission(alert: true, badge: true, sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      fcmToken = await FirebaseMessaging.instance.getToken();
      print("🔥 FCM Token: $fcmToken");

      // استقبال الإشعارات أثناء فتح التطبيق
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        RemoteNotification? notification = message.notification;
        if (notification != null) {
          showNotification(notification.title, notification.body);
        }
      });
      // حالة التطبيق في الخلفية أو مقفول والمستخدم ضغط على الإشعار
      FirebaseMessaging.onMessageOpenedApp.listen((
        RemoteMessage message,
      ) async {
        navigateToScreenFromNotification(message);
      });

      // حالة التطبيق مقفول تماماً وفتح من الإشعار
      FirebaseMessaging.instance.getInitialMessage().then((
        RemoteMessage? message,
      ) async {
        if (message != null) {
          navigateToScreenFromNotification(message);
        }
      });
    } else {
      print('❌ المستخدم رفض الإشعارات');
    }

    setState(() {
      isLoading = false;
    });
  }

  void navigateToScreenFromNotification(RemoteMessage message) {
    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    initFCM();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'QCEC Notify',
      theme: ThemeData(textTheme: GoogleFonts.cairoTextTheme()),

      home: isLoading
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : uid != null
          ? const HomeScreen()
          : const LoginScreen(),
    );
  }
}
