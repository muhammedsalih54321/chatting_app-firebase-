import 'package:chat_app/utils/chat_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/models/message_model.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(MessageModel message) async {
    String chatId = getChatId(message.senderId, message.receiverId);

    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(message.toMap());
  }

  Stream<List<MessageModel>> getMessages(String senderId, String receiverId) {
    String chatId = getChatId(senderId, receiverId);

    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MessageModel.fromMap(doc.data()))
            .toList());
  }
}

