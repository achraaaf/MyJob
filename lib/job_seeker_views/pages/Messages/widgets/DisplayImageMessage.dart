import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:photo_view/photo_view.dart';

class DisplayImageMessage extends StatelessWidget {
  final String ImageUrl;
  final String messageTime;
  final bool isCurrentUser;
  const DisplayImageMessage(
      {super.key,
      required this.ImageUrl,
      required this.messageTime,
      required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PhotoView(
                  imageProvider: NetworkImage(ImageUrl),
                ),
              ),
            );
          },
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(ImageUrl, height: 120)),
        ),
        SizedBox(height: 3),
        Text(messageTime,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ))
      ],
    );
  }
}
