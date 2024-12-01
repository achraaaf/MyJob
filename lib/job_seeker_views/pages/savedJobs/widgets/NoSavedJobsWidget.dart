import 'package:flutter/material.dart';
import 'package:flutter_application_1/job_seeker_views/JobSeekerNavigationBar.dart';
import 'package:google_fonts/google_fonts.dart';

class NoJobsSavedWidget extends StatelessWidget {
  const NoJobsSavedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Text(
                "No Savings",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 22,
                  letterSpacing: -0.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              "You don't have any jobs saved, please find it in search to save jobs",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            Image(image: AssetImage("images/SavingNo.png")),
            Center(
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.6,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BottomNavigationBarJobseeker(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: Color.fromARGB(255, 17, 17, 17),
                  ),
                  child: Text(
                    'Find a Job',
                    style: GoogleFonts.dmSans(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        letterSpacing: 1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
