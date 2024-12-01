import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:MyJob/job_seeker_views/Controllers/JobSeekerController.dart';
import 'package:MyJob/Repositories/authentication/authentication_Repository.dart';
import 'package:MyJob/job_seeker_views/JobSeekerNavigationBar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class editAboutMe extends StatefulWidget {
  const editAboutMe({super.key});

  @override
  State<editAboutMe> createState() => _editAboutMeState();
}

class _editAboutMeState extends State<editAboutMe> {
  late FirebaseAuth auth;
  String? jobSeekerId;
  String? AboutMe;

  TextEditingController _aboutMeController = TextEditingController();

  late JobSeekerController controller;
  final authRepo = Get.put(AuthenticationRepository());

  void initState() {
    super.initState();
    controller = Get.put(JobSeekerController());

    AboutMe = controller.jobSeeker.value.AboutMe;

    jobSeekerId = authRepo.authUser?.uid;

    _aboutMeController.text = AboutMe ?? '';
  }

  Future<String?> saveAboutMe() async {
    try {
      await FirebaseFirestore.instance
          .collection("Job_seekers")
          .doc(jobSeekerId)
          .update({'AboutMe': _aboutMeController.text});

      controller.jobSeeker.value.AboutMe = _aboutMeController.text;
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.only(left: 15),
          icon: Image(image: AssetImage("images/left-arrow.png")),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ========= About Me ===========
              Text(
                "About me",
                style: GoogleFonts.poppins(
                  color: Color(0xFF150B3D),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 25),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 73, 73, 73)
                      .withOpacity(0.10000000149011612),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: TextFormField(
                  controller: _aboutMeController,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 7, left: 20),
                    hintText: 'Tell me about you',
                    hintStyle: GoogleFonts.openSans(
                      color: Color.fromARGB(255, 97, 97, 97),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 70),
              Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 8),
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: ElevatedButton(
                    onPressed: () {
                      _saveData();
                    },
                    child: Text(
                      'Save',
                      style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 1),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05)
            ],
          ),
        ),
      )),
    );
  }

  void _saveData() {
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
                'Changes Saved ?',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Are you sure you want to change what you entered?',
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
                    saveAboutMe();

                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.leftToRight,
                            child:
                                BottomNavigationBarJobseeker(wantedPage: 4)));
                  },
                  child: Text(
                    'Yes Save !',
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
                    'Undo changes !',
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
  }
}
