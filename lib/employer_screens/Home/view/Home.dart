import 'package:MyJob/employer_screens/Controller/EmployerController.dart';
import 'package:MyJob/employer_screens/Employer_Home.dart';
import 'package:MyJob/employer_screens/Home/Widgets/DataChart.dart';
import 'package:MyJob/employer_screens/Home/controller/DataController.dart';
import 'package:MyJob/employer_screens/Home/view/NotificationsView.dart';
import 'package:MyJob/employer_screens/pages/profile/ManagePosts/view/ManagePostsView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class E_Home extends StatefulWidget {
  const E_Home({super.key});

  @override
  State<E_Home> createState() => _E_HomeState();
}

class _E_HomeState extends State<E_Home> {
  late final EmployerController controller;
  late final DataController dataController;

  @override
  void initState() {
    super.initState();
    controller = Get.put(EmployerController());
    dataController = Get.put(DataController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          dataController.FetchData();
        },
        child: SingleChildScrollView(
          child: Obx(
            () {
              final employer = controller.employer.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // header
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xff1f1f1f),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24)),
                    ),
                    padding: EdgeInsets.only(
                        top: 50, right: 15, left: 15, bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundImage:
                                  NetworkImage(employer.CompanyLogo),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Bonjour",
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Image(image: AssetImage("images/Hi.png"))
                                    ],
                                  ),
                                  //SizedBox(height: 5),
                                  Text(
                                    employer.companyName,
                                    style: GoogleFonts.inter(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Color(0xFFDEDEDE),
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(100),
                                    ),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      Get.to(() => NotificationsView());
                                    },
                                    icon: Icon(
                                      Iconsax.notification,
                                      color: Colors.white,
                                      size: 33,
                                    ),
                                  ),
                                ),
                                if (dataController.isNewNoti.value)
                                  Positioned(
                                    top: 10,
                                    right: 14,
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Tableau de bord",
                                style: TextStyle(
                                  fontFamily: 'Satoshi',
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => ManagePostsView());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Color(0xFF2B2B2B),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                child: Text(
                                  "Gérer les offres",
                                  style: TextStyle(
                                    fontFamily: 'Satoshi',
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xff2B2B2B),
                              borderRadius: BorderRadius.circular(24)),
                          padding: EdgeInsets.all(15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Offres Ouvertes",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      '${dataController.openJobs}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 0.7,
                                height: 65,
                                color: Colors.grey[400],
                                child: Divider(
                                  thickness: 0.0,
                                  indent: double
                                      .infinity, // Expands the divider to fill container height
                                  endIndent: double
                                      .infinity, // Expands the divider to fill container height
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Offres en Cours",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      '${dataController.pendingJobs}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 0.7,
                                height: 65,
                                color: Colors.grey[400],
                                child: Divider(
                                  thickness: 0.0,
                                  indent: double.infinity,
                                  endIndent: double.infinity,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Rejeté",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      '${dataController.Rejected}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    color: Color(0xff2B2B2B)),
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Iconsax.profile_2user,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          '${dataController.Hired}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Total Recruté",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    color: Color(0xff2B2B2B)),
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Iconsax.note_25,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          '${dataController.Totalapplicant}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Candidatures Totales",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Répartition des candidatures',
                            style: const TextStyle(
                              fontFamily: 'Satoshi',
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey[500]!,
                                width: 0.5,
                              ),
                              color: Color(0xff1b2339),
                              borderRadius: BorderRadius.circular(24)),
                          padding:
                              EdgeInsets.only(top: 25, bottom: 10, left: 10),
                          child: SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: ApplicationsChart(dataController)),
                        ),
                        SizedBox(height: 13),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey[500]!,
                                width: 0.7,
                              ),
                              borderRadius: BorderRadius.circular(16)),
                          padding: EdgeInsets.only(
                              bottom: 13, left: 10, right: 10, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Trouver des candidats',
                                    style: TextStyle(
                                      fontFamily: 'Satoshi',
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                employer_HomeScreen(
                                                    wantedPage: 1)),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Color(0xff1f1f1f),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        'Rechercher',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Satoshi',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Affinez votre recherche par compétences, expérience ou mots-clés pour trouver le candidat idéal pour vos postes ouverts.',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
