import 'package:MyJob/employer_screens/Employer_Home.dart';
import 'package:MyJob/employer_screens/pages/profile/ManagePosts/controller/ManagePostsController.dart';
import 'package:MyJob/employer_screens/pages/profile/ManagePosts/view/EditJobPostView.dart';
import 'package:MyJob/utils/Time/CalculateTime.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class ManagePostsView extends StatelessWidget {
  ManagePostsView({super.key});

  final controller = Get.put(ManagePostsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Manage Posts",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.off(() => employer_HomeScreen(wantedPage: 4));
          },
          icon: Image(
            image: AssetImage("images/left-arrow.png"),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                Get.off(() => employer_HomeScreen(wantedPage: 2));
              },
              icon: Icon(
                Iconsax.add,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Obx(
          () => ListView.builder(
            itemCount: controller.jobPosts.length,
            itemBuilder: (context, index) {
              final post = controller.jobPosts[index];

              final salary = double.tryParse(
                  post.jobSalary.replaceAll(RegExp(r'[^\d.]'), ''));
              String JobSalary = '\$${(salary! ~/ 1000)}K /Month';

              return Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color:
                            index % 2 == 0 ? Colors.white : Color(0xffF5F5F5),
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 0.4,
                        ),
                        borderRadius: BorderRadius.circular(17),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300]!,
                            spreadRadius: 0.3,
                            blurRadius: 7,
                            offset: Offset(2, 1),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image(
                                    image: NetworkImage(post.EmployerImage),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post.jobTitle,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(JobSalary),
                                SizedBox(height: 5),
                                Text(calculateTimestamp(post.PostedDate))
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              InkWell(
                                  onTap: () {
                                    Get.to(() => EditJobPostView(
                                          jobPost: post,
                                        ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 5),
                                    child: Icon(
                                      Iconsax.edit,
                                    ),
                                  )),
                              SizedBox(height: 5),
                              InkWell(
                                  onTap: () {
                                    Confirmation(context, post.id,
                                        isSaveConfirmation: false);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 5),
                                    child: Icon(Iconsax.trash),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15)
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void Confirmation(BuildContext context, String JobPostId,
      {bool isSaveConfirmation = true}) {
    String title;
    String description;
    String confirm;

    if (isSaveConfirmation) {
      title = 'Changes Saved ?';
      description = 'Are you sure you want to change what you entered?';
      confirm = "Yes save !";
    } else {
      title = 'Remove This Job Post?';
      description = 'Are you sure you want to delete this Job Post?';
      confirm = "Yes Delete !";
    }

    showModalBottomSheet(
      context: context,
      barrierColor: Color(0xFF7E8488).withOpacity(0.5),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ============= for the little bar to slide ===========
              Row(
                children: [
                  Spacer(),
                  Container(
                    height: 4,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey),
                  ),
                  Spacer()
                ],
              ),

              SizedBox(height: 10),
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                description,
                style: GoogleFonts.poppins(
                  color: Color(0xFF514A6B),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                height: 55,
                width: MediaQuery.of(context).size.width * 0.6,
                child: ElevatedButton(
                  onPressed: () {
                    controller.deleteJobPost(JobPostId);
                    Navigator.pop(context);
                  },
                  child: Text(
                    confirm,
                    style: GoogleFonts.dmSans(
                        color: Colors.white,
                        fontSize: 18,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
              Container(
                height: 55,
                width: MediaQuery.of(context).size.width * 0.6,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel !',
                    style: GoogleFonts.dmSans(
                        color: Colors.black,
                        fontSize: 18,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Color(0xFFD7CDFF),
                  ),
                ),
              ),
              SizedBox(height: 20)
            ],
          ),
        );
      },
    );
  }
}
