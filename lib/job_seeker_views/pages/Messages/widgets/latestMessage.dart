import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class LatestMessage extends StatelessWidget {
  final String conversationId;

  const LatestMessage({Key? key, required this.conversationId})
      : super(key: key);

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
          return Text('');
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.data!.docs.isEmpty) {
          return Text('No messages yet');
        }

        final latestMessageData =
            snapshot.data!.docs.first.data() as Map<String, dynamic>;
        final bool isImage = latestMessageData['isImage'] as bool? ?? false;
        final latestMessage = latestMessageData['message'] as String;
        return Text(
          isImage ? 'Image' : latestMessage,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Color(0xff616161),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      },
    );
  }
}
