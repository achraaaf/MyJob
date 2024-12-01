import 'package:MyJob/Authentication/SignIn_Up.dart';
import 'package:MyJob/Repositories/Chat/chatRepository.dart';
import 'package:MyJob/Repositories/user/User_Repository.dart';
import 'package:MyJob/employer_screens/Controller/EmployerController.dart';
import 'package:MyJob/employer_screens/Home/controller/DataController.dart';
import 'package:MyJob/employer_screens/Home/controller/notificationController.dart';
import 'package:MyJob/employer_screens/pages/profile/ManagePosts/view/ManagePostsView.dart';
import 'package:MyJob/employer_screens/pages/profile/editProfile/view/EditProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class OptionsSection extends StatelessWidget {
  const OptionsSection({
    Key? key,
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
              'Modifier le profil',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            subtitle: Text(
              "changer la photo de profil, le numéro, l'e-mail",
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
              'Gérer les publications',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            subtitle: Text(
              "Publier, modifier et suivre vos offres d'emploi",
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
            leading: Icon(Icons.logout),
            title: Text(
              'Se déconnecter',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            subtitle: Text(
              "Déconnectez-vous en toute sécurité du compte",
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
                          'Déconnexion ?',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Êtes-vous sûr de vouloir vous déconnecter?',
                          style: GoogleFonts.poppins(
                            color: Color(0xFF514A6B),
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: ElevatedButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();

                              FirebaseAuth.instance.signOut();

                              Get.delete<EmployerController>(force: true);
                              Get.delete<UserRepository>();
                              Get.delete<ChatRepository>();
                              Get.delete<DataController>();
                              Get.delete<ChatRepository>();
                              Get.delete<notificationsController>();
                              Get.delete<ChatRepository>();

                              Get.offAll(() => signin_up());
                            },
                            child: Text(
                              'Oui, déconnectez-vous !',
                              style: GoogleFonts.dmSans(
                                  color: Colors.white,
                                  fontSize: 20,
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
                          height: 60,
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Annuler !',
                              style: GoogleFonts.dmSans(
                                  color: Colors.black,
                                  fontSize: 20,
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
            },
          ),
        ],
      ),
    );
  }
}
