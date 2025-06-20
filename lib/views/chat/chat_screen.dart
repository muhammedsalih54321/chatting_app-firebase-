import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverEmail;
  final String receivername;

  const ChatScreen({
    super.key,
    required this.receiverId,
    required this.receiverEmail,
    required this.receivername,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  late ChatUser currentChatUser;
  late ChatUser receiverChatUser;

  late String chatId;

  @override
  void initState() {
    super.initState();

    currentChatUser = ChatUser(
      id: currentUser.uid,
      firstName: currentUser.displayName,
    );

    receiverChatUser = ChatUser(
      id: widget.receiverId,
      firstName: widget.receivername,
    );

    chatId = getChatId(currentUser.uid, widget.receiverId);
  }

  String getChatId(String uid1, String uid2) {
    return uid1.hashCode <= uid2.hashCode ? '$uid1\_$uid2' : '$uid2\_$uid1';
  }

  void sendMessage(ChatMessage message) {
    firestore.collection('chats').doc(chatId).collection('messages').add({
      'text': message.text,
      'userId': message.user.id,
      'createdAt': message.createdAt.toIso8601String(),
    });
  }

  Stream<List<ChatMessage>> messageStream() {
    return firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return ChatMessage(
              text: doc['text'],
              user:
                  doc['userId'] == currentUser.uid
                      ? currentChatUser
                      : receiverChatUser,
              createdAt: DateTime.parse(doc['createdAt']),
            );
          }).toList();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121414),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: ListTile(
          title: Text(
            widget.receivername,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              height: 1.h,
            ),
          ),
          subtitle: Text(
            widget.receiverEmail,
            style: GoogleFonts.poppins(
              color: const Color(0xFF797C7B),
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              height: 1,
            ),
          ),
        ),

        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {Navigator.pop(context);},
          icon: Icon(BootstrapIcons.arrow_left, color: Colors.white),
        ),
      ),
      body: StreamBuilder<List<ChatMessage>>(
        stream: messageStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return DashChat(
            currentUser: currentChatUser,
            messages: snapshot.data ?? [],
            onSend: sendMessage,
            messageOptions: const MessageOptions(
              currentUserContainerColor: Color(0xFF00A67E),
              containerColor: Color(0xFF212727),
              textColor: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
