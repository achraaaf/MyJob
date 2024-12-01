import 'package:flutter/material.dart';
import 'package:MyJob/job_seeker_views/Home/Controller/savedJobPostsController.dart';
import 'package:MyJob/Repositories/authentication/authentication_Repository.dart';
import 'package:MyJob/job_seeker_views/Widgets/JobPostDetails/view/JobPostDetails.dart';
import 'package:MyJob/utils/Time/CalculateTime.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class buildSavedPosts extends StatelessWidget {
  const buildSavedPosts({
    super.key,
    required this.controller,
    required this.authRepo,
  });

  final savedJobPostsController controller;
  final AuthenticationRepository authRepo;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.savedJobPosts.length,
        reverse: true,
        itemBuilder: (context, index) {
          final jobPost = controller.savedJobPosts[index];
          final salary = double.tryParse(
              jobPost.jobSalary.replaceAll(RegExp(r'[^\d.]'), ''));
          String JobSalary = '\$${(salary! ~/ 1000)}K /Month';

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => jobPostDetails(
                        jobPost: controller.savedJobPosts[index])),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                margin: EdgeInsets.only(bottom: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 0.5,
                      blurRadius: 10,
                      offset: Offset(2, 1),
                    )
                  ],
                ),
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
                        SizedBox(width: 10),
                        Text(
                          controller.savedJobPosts[index].jobTitle,
                          style: GoogleFonts.poppins(
                            color: Color(0xff181F32),
                            fontSize: 18,
                            letterSpacing: -0.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        Obx(
                          () => IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                barrierColor:
                                    Color(0xFF7E8488).withOpacity(0.5),
                                builder: (BuildContext context) {
                                  return Container(
                                    padding: EdgeInsets.all(16),
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // ============= for the little bar to slide ===========
                                        Row(
                                          children: [
                                            Spacer(),
                                            Container(
                                              height: 4,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.grey),
                                            ),
                                            Spacer()
                                          ],
                                        ),

                                        Text(
                                          "Remove from saved?",
                                          style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          "This job post will be removed from your saved jobs list.",
                                          style: GoogleFonts.poppins(
                                            color: Color(0xFF514A6B),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Container(
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              controller.toggleSavedJobPost(
                                                  controller
                                                      .savedJobPosts[index],
                                                  context);

                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "confirm",
                                              style: GoogleFonts.dmSans(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  letterSpacing: 1,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              backgroundColor: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Cancel !',
                                              style: GoogleFonts.dmSans(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  letterSpacing: 1,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              backgroundColor:
                                                  Color(0xFFD7CDFF),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10)
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            icon: controller.getIconForSavedJobs(
                                controller.savedJobPosts[index]),
                            iconSize: 26,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 7),
                    Divider(
                      color: Color.fromARGB(255, 214, 216, 221),
                      height: 2,
                      thickness: 0.8,
                      indent: 20,
                      endIndent: 20,
                    ),
                    SizedBox(height: 7),
                    Text(
                      jobPost.employerName,
                      style: GoogleFonts.poppins(
                        color: Color(0xff181F32),
                        fontSize: 16,
                        letterSpacing: -0.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      jobPost.jobLocation,
                      style: GoogleFonts.inter(
                        color: Color(0xff181F32),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 7),
                    Wrap(
                      spacing: 10,
                      runSpacing: 7,
                      children: jobPost.jobType.map((type) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.black.withOpacity(0.1),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 4),
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
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          calculateTimestamp(jobPost.PostedDate),
                          style: GoogleFonts.inter(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            JobSalary,
                            style: GoogleFonts.inter(
                              color: Color(0xff181F32),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
