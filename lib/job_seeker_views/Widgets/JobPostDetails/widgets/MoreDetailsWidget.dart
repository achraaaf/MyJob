import 'package:flutter/material.dart';
import 'package:MyJob/Models/JobPosts/JobPostModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';

class MoreDetails extends StatelessWidget {
  const MoreDetails({
    Key? key,
    required this.jobPost,
  }) : super(key: key);

  final JobPostModel jobPost;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ============= Job Description ============

        Text(
          "Description de l'emploi",
          style: GoogleFonts.poppins(
            letterSpacing: -0.5,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 7),
        Text(
          jobPost.jobDescription,
          style: GoogleFonts.inter(
            color: Color(0xff514b6b),
          ),
        ),
        SizedBox(height: 15),
        Text(
          "Exigences",
          style: GoogleFonts.poppins(
            letterSpacing: -0.5,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 7),
        Text(
          jobPost.Requirement,
          style: GoogleFonts.inter(
            color: Color(0xff514b6b),
          ),
        ),
        SizedBox(height: 15),
        Text(
          "Compétences requises",
          style: GoogleFonts.poppins(
            letterSpacing: -0.5,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 7),
        Wrap(
            spacing: 10,
            runSpacing: 7,
            children: jobPost.RequiredSkills.map(
              (requiredSkill) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black.withOpacity(0.1),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                child: Text(
                  requiredSkill,
                  style: GoogleFonts.inter(
                    color: Color(0xff181F32),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ).toList()),
        SizedBox(height: 15),
        if (jobPost.Photos.length != 0)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Photos",
                style: GoogleFonts.poppins(
                  letterSpacing: -0.5,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // ================ photos section ===============
              SizedBox(height: 15),
              SizedBox(
                height: 200,
                child: ListView.separated(
                  separatorBuilder: (context, __) => SizedBox(width: 10),
                  itemCount: jobPost.Photos.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PhotoView(
                              imageProvider:
                                  NetworkImage(jobPost.Photos[index]),
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          jobPost.Photos[index],
                          width: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        SizedBox(height: 100)
      ],
    );
  }
}
