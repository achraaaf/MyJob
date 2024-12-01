import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class timestampWidget extends StatelessWidget {
  final String conversationId;

  const timestampWidget({super.key, required this.conversationId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .doc(conversationId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox.shrink();
        }
        if (snapshot.hasError) {
          return SizedBox.shrink();
        }

        if (snapshot.data!.docs.isEmpty) {
          return SizedBox.shrink();
        }

        final data = snapshot.data!.docs.first.data() as Map<String, dynamic>;
        final timestamp = data['timestamp'] as Timestamp;

        final formattedTime = DateFormat('hh:mm a').format(timestamp.toDate());
        return Text(
          formattedTime,
          style: TextStyle(fontSize: 13),
        );
      },
    );
  }
}
