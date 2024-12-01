import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoMessagesWidget extends StatelessWidget {
  const NoMessagesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(image: AssetImage("images/SavingNo.png")),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Text(
                "No Messages",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 22,
                  letterSpacing: -0.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              "You currently have no incoming messages thank you",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
