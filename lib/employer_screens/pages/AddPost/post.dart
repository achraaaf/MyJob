import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Add_Post extends StatefulWidget {
  const Add_Post({super.key});

  @override
  State<Add_Post> createState() => _Add_PostState();
}

class _Add_PostState extends State<Add_Post> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Text(
                  "Add Post page",
                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 40),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
