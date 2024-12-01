import 'package:MyJob/job_seeker_views/Home/Controller/JobPostController.dart';
import 'package:MyJob/job_seeker_views/Home/view/NotificationsView.dart';
import 'package:flutter/material.dart';
import 'package:MyJob/job_seeker_views/Controllers/JobSeekerController.dart';
import 'package:MyJob/job_seeker_views/Home/Controller/savedJobPostsController.dart';
import 'package:MyJob/Repositories/authentication/authentication_Repository.dart';
import 'package:MyJob/job_seeker_views/Home/widgets/FilterPosts.dart';
import 'package:MyJob/job_seeker_views/Home/widgets/RecentJobsWidget.dart';
import 'package:MyJob/job_seeker_views/Home/widgets/filterProperities.dart';
import 'package:MyJob/job_seeker_views/Home/widgets/popularJobsWidget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final JobSeekerController controller;
  late final savedJobPostsController savedJobController;
  late final JobPostController jobPostController;
  final auth = AuthenticationRepository.instance;

  @override
  void initState() {
    super.initState();
    controller = Get.put(JobSeekerController());
    savedJobController = Get.put(savedJobPostsController());
    jobPostController = Get.put(JobPostController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            jobPostController.fetchJobPosts();
          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Obx(() {
              final jobSeeker = controller.jobSeeker.value;

              final networkImage = jobSeeker.profilePicture;
              final image = networkImage.isNotEmpty
                  ? NetworkImage(networkImage)
                  : AssetImage("images/fitgirl2.jpg");
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Row(
                      // =============== en-tête ===================
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: image as ImageProvider,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Bonjour",
                                  style: GoogleFonts.inter(
                                    color: Color(0xFF585858),
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
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              controller.jobSeeker.value.name,
                              style: GoogleFonts.inter(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Spacer(),
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
                                  size: 33,
                                ),
                              ),
                            ),
                            if (jobPostController.isNewNoti.value)
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
                  ),
                  // ================== Fin en-tête ===================
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Trouvons votre",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -1.7),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Emploi de rêve !",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 33,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -1.4),
                    ),
                  ),
                  SizedBox(height: 10),
                  //====================== barre de recherche ====================
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
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
                        decoration: InputDecoration(
                            hintText: "Recherchez votre rêve !",
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
                                      MaterialPageRoute(
                                        builder: (context) => FilterPosts(),
                                      ),
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            filterPropertiesWidget(),
                                      ),
                                    );
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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FilterPosts(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Emplois populaires",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -1.5),
                    ),
                  ),
                  SizedBox(height: 5),

                  //================== liste des emplois populaires ====================
                  PopularJobsWidget(),
                  // ================== Emplois récents ====================
                  RecentJobsWidget(),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
