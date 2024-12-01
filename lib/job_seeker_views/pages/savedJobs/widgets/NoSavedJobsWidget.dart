import 'package:flutter/material.dart';
import 'package:MyJob/job_seeker_views/JobSeekerNavigationBar.dart';
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
                "Vide",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 22,
                  letterSpacing: -0.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              "Vous n'avez aucune emploi sauvegardé, veuillez le trouver dans la recherche pour sauvegarder des emplois",
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
                height: 50,
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
                    'Trouver un emploi',
                    style: GoogleFonts.dmSans(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
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
