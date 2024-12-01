import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class AboutMeWidget extends StatelessWidget {
  final String? aboutMe;

  const AboutMeWidget({Key? key, required this.aboutMe, required this.onEditPressed}) : super(key: key);

  final VoidCallback onEditPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 18, top: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 73, 73, 73)
                    .withOpacity(0.10000000149011612),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Icon(
                      Iconsax.user,
                      size: 30,
                      color: Color(0xFF574FF2),
                    ), // Change to your own icon
                    SizedBox(width: 13),
                    Text(
                      'About Me',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: onEditPressed,
                      icon: Icon(Iconsax.edit),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 4),
          if (aboutMe != null && aboutMe!.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 73, 73, 73)
                      .withOpacity(0.10000000149011612),
                  borderRadius: BorderRadius.circular(15),
                ),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    aboutMe!,
                    style: GoogleFonts.inter(
                      color: Color(0xFF514A6B),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
