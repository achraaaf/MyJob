import 'package:cloud_firestore/cloud_firestore.dart';

String calculateTimeDifference(String postDate) {
  DateTime dateTime = DateTime.parse(postDate);
  DateTime currentTime = DateTime.now();
  Duration difference = currentTime.difference(dateTime);

  if (difference.inDays > 0) {
    return '${difference.inDays} ${difference.inDays == 1 ? 'jour' : 'jours'}';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} ${difference.inHours == 1 ? 'heure' : 'heures'}';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'}';
  } else {
    return 'À l\'instant';
  }
}

String calculateTimestamp(Timestamp postTimestamp) {
  final DateTime dateTime = postTimestamp.toDate();
  final DateTime currentTime = DateTime.now();
  final Duration difference = currentTime.difference(dateTime);

  if (difference.inDays > 0) {
    return '${difference.inDays} ${difference.inDays == 1 ? 'jour' : 'jours'}';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} ${difference.inHours == 1 ? 'heure' : 'heures'}';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'}';
  } else {
    return 'À l\'instant';
  }
}
