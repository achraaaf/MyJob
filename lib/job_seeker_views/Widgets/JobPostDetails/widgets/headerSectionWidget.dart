
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/Job_seeker/JobPosts/JobPostModel.dart';
import 'package:flutter_application_1/utils/Time/CalculateTime.dart';
import 'package:google_fonts/google_fonts.dart';

class headerSection extends StatelessWidget {
  const headerSection({
    super.key,
    required this.jobPost,
    required this.context,
  });

  final JobPostModel jobPost;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ======= Post image =======

          Container(
            width: MediaQuery.of(context).size.width / 3.5,
            height: MediaQuery.of(context).size.height / 7,
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Color(0xffF5F1FB),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 228, 227, 227),
                  spreadRadius: 0.5,
                  blurRadius: 8,
                  offset: Offset(2, 1),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                image: AssetImage("images/paypal.png"),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            height: 17,
          ),
          // ======= Post title =======
          Text(
            jobPost.jobTitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              letterSpacing: -0.5,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 7),
          Text(
            jobPost.employerName,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              letterSpacing: -0.5,
              color: Color(0xff246bfd),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),

          // ======= Post Location =======
          Text(
            jobPost.jobLocation,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              letterSpacing: -0.5,
              color: Color.fromARGB(255, 63, 63, 63),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(
            height: 7,
          ),
          // ======= jobSalary =======
          Text(
            jobPost.jobSalary,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              letterSpacing: -0.5,
              color: Color(0xff246bfd),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Wrap(
            spacing: 10,
            runSpacing: 7,
            children: jobPost.jobType.map((type) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black.withOpacity(0.1),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: Text(
                  type,
                  style: GoogleFonts.inter(
                    color: Color(0xff181F32),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(
            height: 10,
          ),
          // ========= post date =========
          Text(
            "Posted ${calculateTimeDifference(jobPost.PostedDate)}",
            style: GoogleFonts.inter(
              color: Colors.black.withOpacity(0.8),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

