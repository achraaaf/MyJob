import 'package:flutter/material.dart';
import 'package:MyJob/job_seeker_views/Controllers/JobSeekerController.dart';
import 'package:MyJob/job_seeker_views/pages/profile/EditProfile/controller/editProfileController.dart';
import 'package:MyJob/job_seeker_views/pages/profile/EditProfile/widgets/EditProfileForm.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class editProfileScreen extends StatelessWidget {
  const editProfileScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final JobSeekercontroller = JobSeekerController.instance;
    Get.put(editProfileController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Modifier le profil",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          padding: EdgeInsets.only(left: 10),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image(
            image: AssetImage("images/left-arrow.png"),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                final networkImage =
                    JobSeekercontroller.jobSeeker.value.profilePicture;
                final image = networkImage.isNotEmpty
                    ? NetworkImage(networkImage)
                    : AssetImage("images/fitgirl2.jpg");
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(right: 10, left: 20, bottom: 35),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "images/Background.png",
                        ),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: image as ImageProvider,
                          ),
                          SizedBox(width: 20),
                          Text(
                            JobSeekercontroller.jobSeeker.value.name,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            JobSeekercontroller.jobSeeker.value.city,
                            style: GoogleFonts.poppins(
                              color: Color.fromARGB(255, 231, 229, 229),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          JobSeekercontroller.uploadUserProfilePicture();
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10, bottom: 5),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6)),
                          child: Text(
                            "Changer d'image",
                            style: GoogleFonts.poppins(
                              color: Color.fromARGB(255, 231, 229, 229),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20)
                    ],
                  ),
                );
              }),
              EditProfileForm(
                name: JobSeekercontroller.jobSeeker.value.name,
                city: JobSeekercontroller.jobSeeker.value.city,
                phone: JobSeekercontroller.jobSeeker.value.phone,
              ),
              SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
