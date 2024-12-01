import 'package:flutter/material.dart';
import 'package:MyJob/job_seeker_views/Home/Controller/JobPostController.dart';
import 'package:MyJob/job_seeker_views/Home/Controller/savedJobPostsController.dart';
import 'package:MyJob/job_seeker_views/Home/widgets/filterProperities.dart';
import 'package:MyJob/job_seeker_views/Widgets/JobPostDetails/view/JobPostDetails.dart';
import 'package:MyJob/utils/Time/CalculateTime.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:page_transition/page_transition.dart';

class FilterPosts extends StatelessWidget {
  const FilterPosts({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = JobPostController.instance;
    final savedJobsController = savedJobPostsController.instance;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close)),
                    Text(
                      "Filter",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 20)),
                    ),
                    SizedBox(width: 15)
                  ],
                ),
                //============= search bar ==============
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1.5,
                          blurRadius: 10,
                          offset: Offset(2, 1),
                        )
                      ],
                    ),
                    child: TextField(
                      onChanged: (Value) {
                        controller.searchJobPosts(Value);
                      },
                      decoration: InputDecoration(
                          hintText: "Search Your Dream!",
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 16,
                            letterSpacing: -0.5,
                            fontWeight: FontWeight.w500,
                          ),
                          prefixIcon: Icon(Iconsax.search_normal),
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: Container(
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                                color: Color(0xFF181F32),
                                borderRadius: BorderRadius.circular(15)),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.bottomToTop,
                                          child: filterPropertiesWidget()));
                                },
                                icon: Icon(
                                  Iconsax.filter_search,
                                  color: Colors.white,
                                )),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15)),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 13, vertical: 16)),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Obx(
                    () => Text(
                      "${controller.filteredJobPostsList.length} Founds",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16)),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                //================ filtered posts section ==============

                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.filteredJobPostsList.length,
                    itemBuilder: (context, index) {
                      final jobPost = controller.filteredJobPostsList[index];
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 13),
                            margin: EdgeInsets.only(bottom: 25),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image(
                                            image: NetworkImage(
                                                jobPost.EmployerImage),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        jobPost.jobTitle,
                                        style: GoogleFonts.poppins(
                                          color: Color(0xff181F32),
                                          fontSize: 19,
                                          letterSpacing: -0.5,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Obx(
                                      () => IconButton(
                                        onPressed: () {
                                          savedJobsController
                                              .toggleSavedJobPost(
                                                  jobPost, context);
                                        },
                                        icon: savedJobsController
                                            .getIconForSavedJobs(jobPost),
                                        iconSize: 28,
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
                                SizedBox(height: 5),
                                Text(
                                  jobPost.employerName,
                                  style: GoogleFonts.poppins(
                                    color: Color(0xff181F32),
                                    fontSize: 17,
                                    letterSpacing: -0.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  jobPost.jobLocation,
                                  style: GoogleFonts.inter(
                                    color: Color(0xff181F32),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 7,
                                  children: jobPost.jobType.map((type) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.black.withOpacity(0.1),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 4),
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
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      calculateTimestamp(
                                          jobPost.PostedDate),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
