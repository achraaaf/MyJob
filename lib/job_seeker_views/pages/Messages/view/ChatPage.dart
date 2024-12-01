import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:MyJob/Models/Conversation.dart';
import 'package:MyJob/Models/Employer/Employer.dart';
import 'package:MyJob/Repositories/Chat/chatRepository.dart';
import 'package:MyJob/Repositories/authentication/authentication_Repository.dart';
import 'package:MyJob/job_seeker_views/pages/Messages/controller/messagesController.dart';
import 'package:MyJob/job_seeker_views/pages/Messages/widgets/Chat_bubble.dart';
import 'package:MyJob/job_seeker_views/pages/Messages/widgets/DisplayImageMessage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

class ChatPage extends StatefulWidget {
  final Conversation conversation;
  final Employer employer;
  ChatPage({super.key, required this.conversation, required this.employer});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final chatRepo = ChatRepository.instance;

  late StreamSubscription<QuerySnapshot> _messageSubscription;

  @override
  void initState() {
    super.initState();
    _subscribeToMessages();
  }

  @override
  void dispose() {
    _messageSubscription.cancel();
    super.dispose();
  }

  void _subscribeToMessages() {
    _messageSubscription = FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.conversation.Id)
        .collection('messages')
        .snapshots()
        .listen((snapshot) {
      for (var docChange in snapshot.docChanges) {
        if (docChange.type == DocumentChangeType.added) {
          final messageData = docChange.doc.data();
          final senderId = messageData!['senderId'] as String?;
          final isRead = messageData['isRead'] as bool? ?? false;

          // Check if the message was sent by the other user and is unread
          if (senderId == widget.employer.EmployerId && !isRead) {
            _markMessageAsRead(docChange.doc.reference);
          }
        }
      }
    });
  }

  Future<void> _markMessageAsRead(DocumentReference messageRef) async {
    try {
      await messageRef.update({'isRead': true});
    } catch (e) {
      print('Error marking message as read: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = MessagesController.instance;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Iconsax.arrow_left_2),
                      color: Colors.black),
                  SizedBox(
                    width: 4,
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(widget.employer.CompanyLogo),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(widget.employer.companyName)
                ],
              ),
              Expanded(child: _buildMessageList(controller)),
              SizedBox(height: 6),
              UserInput(controller, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageList(MessagesController controller) {
    return StreamBuilder(
        stream: chatRepo.getMessages(widget.conversation.Id),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error'),
            );
          }

          // loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              width: 500,
              height: 500,
              child: Lottie.asset("images/getting.json"),
            );
          }

          return ListView(
            reverse: true,
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // is currnet user
    bool isCurrentUser =
        data['senderId'] == AuthenticationRepository.instance.authUser!.uid;

    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    Timestamp timestamp = data['timestamp'];
    DateTime dateTime = timestamp.toDate();
    String messageTime =
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      alignment: alignment,
      child: Row(
        mainAxisAlignment:
            isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isCurrentUser)
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(widget.employer.CompanyLogo),
            ),
          SizedBox(width: 5),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 300),
            child: Column(
              children: [
                if (data['isImage'] == true)
                  DisplayImageMessage(
                      ImageUrl: data['message'],
                      messageTime: messageTime,
                      isCurrentUser: isCurrentUser),
                if (data['isImage'] == false)
                  ChatBubble(
                    message: data['message'],
                    isCurrentUser: isCurrentUser,
                    time: messageTime,
                    isRead: data['isRead'],
                  ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget UserInput(MessagesController controller, BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextFormField(
          controller: controller.messageController,
          decoration: InputDecoration(
              hintText: "Écrivez votre message",
              hintStyle: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              filled: true,
              fillColor: Colors.black.withOpacity(0.10000000149011612),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(13)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(13)),
              prefixIcon: Icon(Iconsax.message),
              suffixIcon: IconButton(
                  onPressed: () {
                    controller.uploadImage(
                        widget.conversation.Id, widget.conversation.EmployerId);
                  },
                  icon: Icon(Iconsax.image)),
              contentPadding: EdgeInsets.symmetric(horizontal: 15)),
        )),
        IconButton(
          onPressed: () {
            controller.sendMessage(
              widget.conversation.Id,
              widget.conversation.EmployerId,
            );
          },
          icon: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            decoration: BoxDecoration(
                color: Color(0xff130160),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(
              Iconsax.send1,
              color: Colors.white,
              size: 22,
            ),
          ),
        )
      ],
    );
  }
}
