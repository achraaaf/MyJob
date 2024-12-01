import 'package:MyJob/Models/JobPosts/JobPostModel.dart';
import 'package:MyJob/utils/Time/CalculateTime.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JobPostWidget extends StatelessWidget {
  const JobPostWidget({
    super.key,
    required this.jobPost,
    required this.jobSalary,
  });

  final JobPostModel jobPost;
  final String jobSalary;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 17, 17, 17),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      image: NetworkImage(jobPost.EmployerImage),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jobPost.jobTitle,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: -0.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    jobPost.employerName,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: -0.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            jobPost.jobLocation,
            style: GoogleFonts.inter(
              color: Colors.white.withOpacity(0.9),
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 10,
            runSpacing: 7,
            children: jobPost.jobType.map((type) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white.withOpacity(0.1),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: Text(
                  type,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                calculateTimeDifference(jobPost.PostedDate),
                style: GoogleFonts.inter(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  jobSalary,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
