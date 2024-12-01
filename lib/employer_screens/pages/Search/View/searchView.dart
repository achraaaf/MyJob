import 'package:MyJob/Models/Job_seeker/Job_seeker.dart';
import 'package:MyJob/employer_screens/pages/Search/Controller/SearchController.dart';
import 'package:MyJob/employer_screens/pages/Search/View/JobSeekerDetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late SearchJobSeekersController controller;

  @override
  void initState() {
    controller = Get.put(SearchJobSeekersController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Recherche",
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          leading: SizedBox.shrink()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
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
                  hintText:
                      "Rechercher des candidats par nom, compétences, expérience",
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 16,
                    letterSpacing: -0.5,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: Icon(Iconsax.search_normal),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 13, vertical: 16),
                ),
                onChanged: (value) => controller.SearchJobSeekers(value),
                onTap: () {},
              ),
            ),
            SizedBox(height: 10),
            // Search Results
            Obx(() {
              if (controller.isLoading.value)
                return Flexible(
                  child: SizedBox(
                    width: 500,
                    height: 500,
                    child: Lottie.asset("images/getting.json"),
                  ),
                );
              return Expanded(
                child: ListView.builder(
                  itemCount: controller.FiltredjobSeekers.length,
                  itemBuilder: (context, index) {
                    final jobSeeker = controller.FiltredjobSeekers[index];
                    return JobSeekerCard(jobSeeker: jobSeeker);
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class JobSeekerCard extends StatelessWidget {
  final Job_seeker jobSeeker;
  const JobSeekerCard({Key? key, required this.jobSeeker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(() => JobSeekerDetails(jobSeeker: jobSeeker));
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[200],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(jobSeeker.profilePicture),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        jobSeeker.name,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        jobSeeker.city,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Get.to(() => JobSeekerDetails(jobSeeker: jobSeeker));
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFF181F32),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Row(
                      children: [
                        Icon(
                          Iconsax.arrow_right_3,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
