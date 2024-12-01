import 'package:MyJob/Authentication/SignIn_Up.dart';
import 'package:MyJob/employer_screens/pages/profile/ManagePosts/view/ManagePostsView.dart';
import 'package:MyJob/employer_screens/pages/profile/editProfile/view/EditProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class OptionsSection extends StatelessWidget {
  const OptionsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      width: double.infinity,
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(Iconsax.user),
            title: Text(
              'Edit Profile',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            subtitle: Text(
              "change profile picture, number, email",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            trailing: Icon(Iconsax.arrow_right_34),
            contentPadding: EdgeInsets.all(0),
            onTap: () {
              Get.to(() => EditProfile());
            },
          ),
          ListTile(
            leading: Icon(Iconsax.briefcase),
            title: Text(
              'Manage Posts',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            subtitle: Text(
              "Post, Edit, and Track Your Openings",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            trailing: Icon(Iconsax.arrow_right_34),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ManagePostsView(),
                ),
              );
            },
            contentPadding: EdgeInsets.all(0),
          ),
          ListTile(
            leading: Icon(Iconsax.setting),
            title: Text(
              'Settings',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            subtitle: Text(
              "Update Profile, Security, and Preferences",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            trailing: Icon(Iconsax.arrow_right_34),
            contentPadding: EdgeInsets.all(0),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              'Log out',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            subtitle: Text(
              "Securely log out of Account",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            trailing: Icon(Iconsax.arrow_right_34),
            contentPadding: EdgeInsets.all(0),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      title: Center(
                        child: Text(
                          'Log Out',
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      content: Container(
                        height: 200,
                        child: Column(
                          children: [
                            Text(
                              'Are you sure you want to log out?',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromARGB(255, 94, 94, 94),
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Get.offAll(() => signin_up());
                              },
                              child: Text(
                                "Yes, Log Out",
                                style: GoogleFonts.dmSans(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 13),
                              ),
                            ),
                            SizedBox(height: 10),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Cancel",
                                style: GoogleFonts.dmSans(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                side: BorderSide(
                                  color: Colors.grey,
                                  width: 0.5,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 13),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
