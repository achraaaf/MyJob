import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/JobSeekerController.dart';
import 'package:flutter_application_1/Repositories/authentication/authentication_Repository.dart';
import 'package:flutter_application_1/job_seeker_views/Home/Controller/JobPostController.dart';
import 'package:flutter_application_1/job_seeker_views/Home/widgets/RecentJobsWidget.dart';
import 'package:flutter_application_1/job_seeker_views/Home/widgets/popularJobsWidget.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final controller = Get.put(JobSeekerController());
final auth = AuthenticationRepository.instance;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    print("============== im here ===============");
    print(controller.jobSeeker.value.name);
    print(auth.authUser!.uid);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: SingleChildScrollView(
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
                      // =============== header ===================
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
                                  "Good Morning",
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
                            onPressed: () {},
                            icon: Icon(
                              Iconsax.notification,
                              size: 33,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // ================== End header ===================
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Let's Find Your",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -1.7),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Dream Job!",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 35,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -1.4),
                    ),
                  ),
                  SizedBox(height: 20),
                  //====================== search bar ====================
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
                                  onPressed: () {},
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
                                horizontal: 13, vertical: 20)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Popular Jobs",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -1.5),
                    ),
                  ),
                  SizedBox(height: 20),

                  //================== popular jobs listview ====================
                  PopularJobsWidget(),
                  // ================== Recent Job Posts ====================
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
