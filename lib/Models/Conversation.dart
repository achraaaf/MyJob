import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation {
  final String Id;
  final String JobSeekerId;
  final String EmployerId;
   Timestamp lastMessageTime ;

  Conversation(
      {required this.Id,
      required this.JobSeekerId,
      required this.EmployerId,
      required this.lastMessageTime
});

  factory Conversation.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Conversation(
      Id: doc.id,
      JobSeekerId: data['jobSeekerId'] ?? '',
      EmployerId: data['employerId'] ?? '',
      lastMessageTime: data['lastMessageTime']?? Timestamp.now(),
    );
  }
}
