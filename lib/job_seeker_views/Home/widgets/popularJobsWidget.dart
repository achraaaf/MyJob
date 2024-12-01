import 'package:flutter/material.dart';
import 'package:MyJob/job_seeker_views/Home/Controller/JobPostController.dart';
import 'package:MyJob/job_seeker_views/Home/Controller/savedJobPostsController.dart';
import 'package:MyJob/job_seeker_views/Widgets/JobPostDetails/view/JobPostDetails.dart';
import 'package:MyJob/utils/Time/CalculateTime.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class PopularJobsWidget extends StatefulWidget {
  const PopularJobsWidget({super.key});

  @override
  State<PopularJobsWidget> createState() => _PopularJobsWidgetState();
}

class _PopularJobsWidgetState extends State<PopularJobsWidget> {
  PageController pageController = PageController(viewportFraction: 0.80);

  final controller = Get.put(JobPostController());
  final savedJobsController = Get.put(savedJobPostsController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        height: 200,
        child: Obx(() {
          return PageView.builder(
            controller: pageController,
            itemCount: controller.PopularJobPosts.length,
            itemBuilder: (context, index) {
              final jobPost = controller.PopularJobPosts[index];

              final salary = double.tryParse(
                  jobPost.jobSalary.replaceAll(RegExp(r'[^\d.]'), ''));
              String JobSalary = '\$${(salary! ~/ 1000)}K /Month';

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.bottomToTop,
                          child: jobPostDetails(jobPost: jobPost)));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 17, 17, 17),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(2, 1),
                      )
                    ],
                  ),
                  padding:
                      EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 5),
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
                          Spacer(),
                          Obx(
                            () => IconButton(
                              onPressed: () {
                                savedJobsController.toggleSavedJobPost(
                                    jobPost, context);
                              },
                              icon: savedJobsController
                                  .getIconForSavedJobs(jobPost),
                              iconSize: 28,
                              color: Colors.white,
                            ),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 4),
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
                            calculateTimestamp(jobPost.PostedDate),
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
                              JobSalary,
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
                ),
              );
            },
          );
        }),
      );
    });
  }
}
