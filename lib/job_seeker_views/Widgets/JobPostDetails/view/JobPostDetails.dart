import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/Job_seeker/JobPosts/JobPostModel.dart';
import 'package:flutter_application_1/job_seeker_views/Widgets/JobPostDetails/widgets/MoreDetailsWidget.dart';
import 'package:flutter_application_1/job_seeker_views/Widgets/JobPostDetails/widgets/headerSectionWidget.dart';
import 'package:flutter_application_1/job_seeker_views/Widgets/application/view/ApplyByCVview.dart';
import 'package:google_fonts/google_fonts.dart';

class jobPostDetails extends StatelessWidget {
  final JobPostModel jobPost;
  jobPostDetails({required this.jobPost, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image(
            image: AssetImage("images/left-arrow.png"),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ================ header ===============

                  headerSection(jobPost: jobPost, context: context),

                  SizedBox(height: 15),
                  Divider(
                    color: Colors.grey.withOpacity(0.3),
                    thickness: 2,
                    indent: 30,
                    endIndent: 30,
                  ),
                  SizedBox(height: 15),

                  // ================ More details Section ===============

                  MoreDetails(jobPost: jobPost)
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20, left: 5, right: 5),
                child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: 50,
                      blurRadius: 30,
                      offset: Offset(0, 15),
                    ),
                  ]),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: FloatingActionButton(
                            backgroundColor: Colors.black,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ApplyWithCVview(
                                          jobPost: jobPost,
                                        )),
                              );
                            },
                            child: Text(
                              "Apply Job",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 15,
                                letterSpacing: -0.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: FloatingActionButton(
                            backgroundColor: Colors.white,
                            onPressed: () {},
                            child: Text(
                              "Send Message",
                              style: GoogleFonts.poppins(
                                color: const Color.fromARGB(255, 20, 20, 20),
                                fontSize: 15,
                                letterSpacing: -0.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: BorderSide(
                                    color: Color.fromARGB(255, 32, 32, 32),
                                    width: 0.4)),
                          ),
                        ),
                      ),
                    ],
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