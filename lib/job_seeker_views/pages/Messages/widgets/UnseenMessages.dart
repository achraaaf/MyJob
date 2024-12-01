import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UnseenMessages extends StatelessWidget {
  final String conversationId;
  final String receiverId;

  const UnseenMessages({
    Key? key,
    required this.conversationId,
    required this.receiverId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .doc(conversationId)
          .collection('messages')
          .where('senderId', isEqualTo: receiverId)
          .where('isRead', isEqualTo: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final unseenCount = snapshot.data!.docs.length;
          return unseenCount > 0
              ? Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      unseenCount.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 9),
                    ),
                  ),
                )
              : SizedBox.shrink();
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
