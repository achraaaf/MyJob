import 'package:intl/intl.dart';

String calculateTimeDifference(String postDate) {
  DateTime dateTime = DateTime.parse(postDate);
  DateTime currentTime = DateTime.now();
  Duration difference = currentTime.difference(dateTime);

  if (difference.inDays > 0) {
    return '${difference.inDays} ${difference.inDays == 1 ? 'Day' : 'Days'} ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} ${difference.inHours == 1 ? 'Hour' : 'Hours'} ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'Minute' : 'Minute'} ago';
  } else {
    return 'Just now';
  }
}
