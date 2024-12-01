import 'package:MyJob/employer_screens/Controller/EmployerController.dart';
import 'package:MyJob/employer_screens/pages/profile/editProfile/controller/editProfileController.dart';
import 'package:MyJob/employer_screens/pages/profile/editProfile/widgets/EditProfileForm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});

  final controller = EmployerController.instance;
  final editProfilecontroller = Get.put(editProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
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
            Get.back();
          },
          icon: Image(
            image: AssetImage("images/left-arrow.png"),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // edit company image
                  Obx(
                    () => Container(
                      child: Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image(
                                    image: NetworkImage(
                                        controller.employer.value.CompanyLogo),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 53, 53, 53),
                                    width: 0.4,
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                    padding: EdgeInsets.all(0),
                                    onPressed: () {
                                      controller.uploadUserProfilePicture();
                                    },
                                    icon: Icon(Iconsax.edit_2, size: 20),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  // edit Form
                  EditProfileForm(
                    employer: controller.employer.value,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 10, left: 5, right: 5),
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
                      SizedBox(width: 70),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: FloatingActionButton(
                            backgroundColor: Colors.black,
                            onPressed: () {
                              editProfilecontroller.SaveChanges(context);
                            },
                            child: Text(
                              "Save Changes",
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
                      SizedBox(width: 70),
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

  TextFormField TextField({final validator}) {
    return TextFormField(
      style: TextStyle(
        color: Colors.black,
      ),
      validator: validator,
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.black.withOpacity(0.10000000149011612),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(13)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(13)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(13)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(13)),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      ),
    );
  }
}
