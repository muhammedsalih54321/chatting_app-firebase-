import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/views/auth/forgotpassword_screen.dart';
import 'package:chat_app/views/auth/login_screen.dart';
import 'package:chat_app/views/auth/register_screen.dart';
import 'package:chat_app/views/chat/chat_screen.dart';
import 'package:chat_app/views/home_screen.dart';
import 'package:chat_app/views/splash_screen.dart';
import 'package:chat_app/views/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // You can handle background logic here
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? child) {
        return MultiProvider(
          providers: [ChangeNotifierProvider(create: (_) => Authprovider())],
          child: MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF20A090)),
            ),
            debugShowCheckedModeBanner: false,
            title: 'chat_app',
            initialRoute: '/',
            routes: {
              '/': (context) => SplashScreen(),
              '/welcome': (context) => WelcomeScreen(),
              '/login': (context) => LoginScreen(),
              '/signup': (context) => Signupscreen(),
              '/home': (context) => HomeScreen(),

              '/forgot': (context) => ForgotpasswordScreen(),
            },
          ),
        );
      },
    );
  }
}
