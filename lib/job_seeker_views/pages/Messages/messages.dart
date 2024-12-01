import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: Text(
          "messages page",
          style: GoogleFonts.poppins(color: Colors.black),
        ))),

    );
  }
}
