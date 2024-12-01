import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final String time;
  final bool isRead;
  const ChatBubble(
      {super.key,
      required this.message,
      required this.isCurrentUser,
      required this.time,
      required this.isRead});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(left: 10, right: 30, top: 5, bottom: 16),
          decoration: BoxDecoration(
              color:
                  isCurrentUser ? const Color(0xff0130160) : Color(0xffe9e7e9),
              borderRadius: isCurrentUser
                  ? BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(4),
                    )
                  : BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )),
          child: Text(
            message,
            style:
                TextStyle(color: isCurrentUser ? Colors.white : Colors.black),
          ),
        ),
        Positioned(
          right: 5,
          bottom: 3,
          child: Row(
            children: [
              Text(
                time,
                style: TextStyle(
                  color: isCurrentUser ? Colors.white : Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: 3),
              isCurrentUser
                  ? Icon(
                      isRead ? Icons.done_all : Icons.done_all,
                      size: 16,
                      color: isRead ? Color(0xff90EE90) : Colors.white,
                    )
                  : SizedBox.shrink()
            ],
          ),
        )
      ],
    );
  }
}
