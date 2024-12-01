import 'package:flutter/material.dart';
import 'package:MyJob/job_seeker_views/Controllers/JobSeekerController.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class AboutMeWidget extends StatelessWidget {
  final String? aboutMe;

  const AboutMeWidget(
      {Key? key, required this.aboutMe, required this.onEditPressed})
      : super(key: key);

  final VoidCallback onEditPressed;
  @override
  Widget build(BuildContext context) {
    final controller = JobSeekerController.instance;
    return Container(
      margin: EdgeInsets.only(bottom: 18, top: 5),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1.5,
                blurRadius: 10,
                offset: Offset(2, 1),
              )
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Row(
                  children: [
                    Icon(
                      Iconsax.user,
                      size: 30,
                      color: Color(0xFF574FF2),
                    ), // Change to your own icon
                    SizedBox(width: 13),
                    Text(
                      'À propos de moi',
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
              if (aboutMe != null && aboutMe!.isNotEmpty)
                Obx(
                  () => Column(
                    children: [
                      Divider(
                        color: Color(0xFFDEE1E7),
                        height: 3,
                        thickness: 0.8,
                        indent: 20,
                        endIndent: 20,
                      ),
                      Container(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            controller.jobSeeker.value.AboutMe.trim(),
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
