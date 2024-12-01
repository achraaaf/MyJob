import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        elevation: 5, 
      ),
      child: Text(
        "Apply with CV",
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 15,
          letterSpacing: -0.5,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
