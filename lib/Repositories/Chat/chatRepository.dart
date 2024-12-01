import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:MyJob/Models/Conversation.dart';
import 'package:MyJob/Models/Message.dart';
import 'package:MyJob/Repositories/authentication/authentication_Repository.dart';
import 'package:get/get.dart';

class ChatRepository extends GetxController {
  static ChatRepository get instance => Get.find();

  // varibales
  final currentUser = AuthenticationRepository.instance.authUser!.uid;
  final _db = FirebaseFirestore.instance.collection("chats");

  // get the already users chatted with
  Future<List<Conversation>> getChats(String User) async {
    final chatsRef = FirebaseFirestore.instance.collection("chats");
    final querySnapshot =
        await chatsRef.where(User, isEqualTo: currentUser).get();

    final ConversationsList = querySnapshot.docs
        .map((doc) => Conversation.fromSnapshot(doc))
        .toList();

    ConversationsList.sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));

    return ConversationsList;
  }

  Stream<Conversation> listenForNewConversations(String currentUserId) {
    final conversationsRef = FirebaseFirestore.instance.collection('chats');

    return conversationsRef
        .where(Filter.or(Filter("employerId", isEqualTo: currentUserId),
            Filter("jobSeekerId", isEqualTo: currentUserId)))
        .snapshots()
        .map((snapshot) => snapshot.docChanges
            .where((change) => change.type == DocumentChangeType.added)
            .map((change) => Conversation.fromSnapshot(change.doc))
            .first);
  }

  // create a new chat room
  Future<void> createChatConversation(
      {required String jobSeekerId, required String employerId}) async {
    final chatQuery = _db
        .where("jobSeekerId", isEqualTo: jobSeekerId)
        .where("employerId", isEqualTo: employerId);
    final querySnapshot = await chatQuery.get();

    if (querySnapshot.docs.isEmpty) {
      final newChatId = _db.doc().id;
      await _db.doc(newChatId).set({
        'jobSeekerId': jobSeekerId,
        'employerId': employerId,
        'lastMessageTime': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<Conversation> getChatConversation(
      {required String jobSeekerId, required String employerId}) async {
    final chatQuery = _db
        .where("jobSeekerId", isEqualTo: jobSeekerId)
        .where("employerId", isEqualTo: employerId);
    final querySnapshot = await chatQuery.get();
    final doc = querySnapshot.docs.first;
    return Conversation.fromSnapshot(doc);
  }

  // send a message
  Future<void> sendMessage(
      String ChatRoomId, String ReceiverID, message, bool isImage) async {
    // GET THE CURRENT USER INFO
    final String currentUserID = FirebaseAuth.instance.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
        message: message,
        senderId: currentUserID,
        receiverId: ReceiverID,
        timestamp: timestamp,
        isRead: false,
        isImage: isImage);

    // add the new message to the database
    await _db.doc(ChatRoomId).collection("messages").add(newMessage.toMap());
    await _db.doc(ChatRoomId).update({
      'lastMessageTime': timestamp,
    });
  }

  // get the messages
  Stream<QuerySnapshot> getMessages(String ChatRoomId) {
    return _db
        .doc(ChatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  Future<int> getUnseenCount(String conversationId) async {
    final unseenCountQuery = _db
        .doc(conversationId)
        .collection('messages')
        .where('receiverId', isNotEqualTo: currentUser)
        .where('isRead', isEqualTo: false)
        .snapshots();

    final firstDocSnap = await unseenCountQuery.first;
    final unseenCount = firstDocSnap.docs.length;
    return unseenCount;
  }
}
