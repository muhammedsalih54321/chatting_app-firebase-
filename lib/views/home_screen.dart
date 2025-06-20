import 'package:chat_app/views/chat/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

void requestPermission() async {
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  }
}
 void _initFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((message) {
      print("🔔 Message received in foreground: ${message.notification?.title}");
      // Show alert or toast here if needed
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("📬 User tapped the notification: ${message.data}");
      // You can navigate to ChatScreen here if needed
    });
  }

  @override
  void initState() {
   requestPermission();
   _initFirebaseMessaging();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFF27736A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF27736A),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Home",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: Container(
          width: 44.w,
          height: 44.h,
          decoration: ShapeDecoration(
            color: const Color(0xFF24786D),
            shape: OvalBorder(
              side: BorderSide(width: 1.w, color: const Color(0xFF4A9188)),
            ),
          ),
          child: Center(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(BootstrapIcons.search, color: Colors.white),
            ),
          ),
        ),

        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Container(
              width: 44.w,
              height: 44.h,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/Logo2.png"),
                  fit: BoxFit.fill,
                ),
                shape: OvalBorder(),
              ),
            ),
          ),
        ],
        bottom: AppBar(backgroundColor: const Color(0xFF24786D)),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.hasError) {
              return const Center(child: CircularProgressIndicator());
            }

            final docs = snapshot.data!.docs;
            final users =
                docs
                    .where((doc) => doc['uid'] != currentUser?.uid)
                    .toList(); // Exclude self

            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => ChatScreen(
                              receiverId: user['uid'],
                              receiverEmail: user['email'],
                              receivername: user['name'],
                            ),
                      ),
                    );
                  },
                  leading: const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                  ),
                  title: Text(
                    user['name'],
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.h,
                    ),
                  ),
                  subtitle: Text(
                    "How are you today?",
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                  ),
                  trailing: Text(
                    "2 min ago",
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
