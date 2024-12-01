import 'package:MyJob/employer_screens/Controller/EmployerController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class ProfileHeader extends StatelessWidget {
  ProfileHeader({
    Key? key,
  });

  final controller = EmployerController.instance;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final employer = controller.employer.value;

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                image: DecorationImage(
                  image: AssetImage('images/300x.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                          image: NetworkImage(employer.CompanyLogo),
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
                          employer.companyName,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(height: 3),
                        Row(
                          children: [
                            Icon(
                              Iconsax.location,
                              color: Colors.white,
                            ),
                            Text(
                              employer.city,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Taille de l\'entreprise',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(employer.companySize),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Industrie',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(employer.Industry),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Informations de contact',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(employer.email),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Divider(
              color: Color.fromARGB(255, 214, 217, 224),
              height: 1,
              thickness: 0.8,
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(height: 7),
            Text(
              "À propos",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.1,
                  fontSize: 15,
                ),
              ),
            ),
            Text(employer.description),
          ],
        ),
      );
    });
  }
}
