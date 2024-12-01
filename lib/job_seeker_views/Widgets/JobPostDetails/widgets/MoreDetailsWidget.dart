import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/Job_seeker/JobPosts/JobPostModel.dart';
import 'package:google_fonts/google_fonts.dart';

class MoreDetails extends StatelessWidget {
  const MoreDetails({
    super.key,
    required this.jobPost,
  });

  final JobPostModel jobPost;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ============= Job Description ============

        Text(
          "Job Description",
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
          "Requirements",
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
          "Required Skills",
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
                              fullscreenDialog: true,
                              builder: (context) => Dialog.fullscreen(
                                    child: SafeArea(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Image(
                                                image: AssetImage(
                                                    "images/left-arrow.png"),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                              child: Image(
                                                  image: NetworkImage(
                                                      jobPost.Photos[index])),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
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
              SizedBox(height: 100)
            ],
          ),
      ],
    );
  }
}
