import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/job_seeker_views/job_seeker_Home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class editWordExperience extends StatefulWidget {
  final String jobTitle;
  final String company;
  final String start_date;
  final String end_date;
  final String description;

  const editWordExperience({
    required this.jobTitle,
    required this.company,
    required this.start_date,
    required this.end_date,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  State<editWordExperience> createState() => _editWordExperienceState();
}

class _editWordExperienceState extends State<editWordExperience> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late FirebaseAuth auth;
  String? jobSeekerId;
  late FirebaseFirestore firestore;

  TextEditingController jobTitleController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  AutovalidateMode _jobTitleAutovalidateMode = AutovalidateMode.disabled;
  AutovalidateMode _companyAutovalidateMode = AutovalidateMode.disabled;
  AutovalidateMode _startDateAutovalidateMode = AutovalidateMode.disabled;
  AutovalidateMode _endDateAutovalidateMode = AutovalidateMode.disabled;

  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
    jobSeekerId = auth.currentUser?.uid;

    jobTitleController.text = widget.jobTitle;
    companyController.text = widget.company;
    startDateController.text = widget.start_date;
    endDateController.text = widget.end_date;
    descriptionController.text = widget.description;
  }

  void dispose() {
    super.dispose();
    jobTitleController.dispose();
    companyController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Change work experience',
                    style: GoogleFonts.dmSans(
                      color: Color(0xFF150B3D),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  // =============================================================
                  // ======================= add job title ======================
                  SizedBox(height: 25),
                  Text(
                    'Job title',
                    style: GoogleFonts.dmSans(
                      color: Color(0xFF150B3D),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 55,
                    padding: EdgeInsets.only(bottom: 3),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 73, 73, 73)
                          .withOpacity(0.10000000149011612),
                      borderRadius: const BorderRadius.all(Radius.circular(13)),
                    ),
                    child: TextFormField(
                      controller: jobTitleController,
                      autovalidateMode: _jobTitleAutovalidateMode,
                      onChanged: (value) {
                        setState(() {
                          _jobTitleAutovalidateMode =
                              AutovalidateMode.onUserInteraction;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a job title';
                        }
                        return null;
                      },
                      style: GoogleFonts.dmSans(
                          color: Colors.black, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 20),
                      ),
                    ),
                  ),

                  // ==================================================================
                  // ========================== add company ==========================
                  SizedBox(height: 15),
                  Text(
                    'Company',
                    style: GoogleFonts.dmSans(
                      color: Color(0xFF150B3D),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 55,
                    padding: EdgeInsets.only(bottom: 3),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 73, 73, 73)
                          .withOpacity(0.10000000149011612),
                      borderRadius: const BorderRadius.all(Radius.circular(13)),
                    ),
                    child: TextFormField(
                      controller: companyController,
                      autovalidateMode: _companyAutovalidateMode,
                      onChanged: (value) {
                        setState(() {
                          _companyAutovalidateMode =
                              AutovalidateMode.onUserInteraction;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a the company name';
                        }
                        return null;
                      },
                      style: GoogleFonts.dmSans(
                          color: Colors.black, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 20),
                      ),
                    ),
                  ),
                  // ==============================================
                  // =================== date =====================
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Start date',
                              style: GoogleFonts.dmSans(
                                color: Color(0xFF150B3D),
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 50,
                              padding: EdgeInsets.only(bottom: 3),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 73, 73, 73)
                                    .withOpacity(0.10000000149011612),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(13)),
                              ),
                              child: TextFormField(
                                controller: startDateController,
                                autovalidateMode: _startDateAutovalidateMode,
                                onChanged: (value) {
                                  setState(() {
                                    _startDateAutovalidateMode =
                                        AutovalidateMode.onUserInteraction;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a date';
                                  }
                                  return null;
                                },
                                style: GoogleFonts.dmSans(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'End date',
                              style: GoogleFonts.dmSans(
                                color: Color(0xFF150B3D),
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 50,
                              padding: EdgeInsets.only(bottom: 3),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 73, 73, 73)
                                    .withOpacity(0.10000000149011612),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(13)),
                              ),
                              child: TextFormField(
                                controller: endDateController,
                                autovalidateMode: _endDateAutovalidateMode,
                                onChanged: (value) {
                                  setState(() {
                                    _endDateAutovalidateMode =
                                        AutovalidateMode.onUserInteraction;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a date';
                                  }
                                  return null;
                                },
                                style: GoogleFonts.dmSans(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  // ===========================================================
                  // ==================== description ===========================
                  SizedBox(height: 15),
                  Text(
                    "Desciption",
                    style: GoogleFonts.dmSans(
                      color: Color(0xFF150B3D),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.18,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 73, 73, 73)
                          .withOpacity(0.10000000149011612),
                      borderRadius: const BorderRadius.all(Radius.circular(13)),
                    ),
                    child: TextFormField(
                      controller: descriptionController,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 7, left: 20),
                        hintText: 'Write additional information here',
                        hintStyle: GoogleFonts.dmSans(
                          color: Color.fromARGB(255, 97, 97, 97),
                        ),
                      ),
                    ),
                  ),

                  // ================================================================
                  // ======================== Save , remove ===================
                  Spacer(),
                  Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        // ========================= Remove ====================
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 8),
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                Confirmation(isSaveConfirmation: false);
                              },
                              child: Text(
                                'Remove',
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
                                primary: Color(0xFFD6CDFE),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15),

                        // ========================== save =======================
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 8),
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                Confirmation(isSaveConfirmation: true);
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
                                primary: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _updateWorkExperience() async {
    if (_formKey.currentState!.validate()) {
      var querySnapshot = await FirebaseFirestore.instance
          .collection("Job_seekers")
          .doc(jobSeekerId)
          .collection("workExperiences")
          .where('title', isEqualTo: widget.jobTitle)
          .get();

      var documentID = querySnapshot.docs.first.id;

      await FirebaseFirestore.instance
          .collection("Job_seekers")
          .doc(jobSeekerId)
          .collection("workExperiences")
          .doc(documentID)
          .update({
        'title': jobTitleController.text,
        'company': companyController.text,
        'Start_date': startDateController.text,
        'End_date': endDateController.text,
        'description': descriptionController.text,
      });

      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.leftToRight,
              child: BottomNavigationBarJobseekerApp()));
    }
  }

  void deleteWorkExperience() async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection("Job_seekers")
        .doc(jobSeekerId)
        .collection("workExperiences")
        .where('title', isEqualTo: widget.jobTitle)
        .get();

    var documentID = querySnapshot.docs.first.id;
    await FirebaseFirestore.instance
        .collection("Job_seekers")
        .doc(jobSeekerId)
        .collection("workExperiences")
        .doc(documentID)
        .delete();
  }

  // ========== confirmation bar ============
  void Confirmation({bool isSaveConfirmation = true}) {
    String title;
    String description;
    String confirm;

    if (isSaveConfirmation) {
      title = 'Changes Saved ?';
      description = 'Are you sure you want to change what you entered?';
      confirm = "Yes save !";
    } else {
      title = 'Remove work experience?';
      description = 'Are you sure you want to delete this work experience?';
      confirm = "Yes Delete !";
    }

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
                title,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                description,
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
                    if (isSaveConfirmation) {
                      _updateWorkExperience();
                    } else {
                      deleteWorkExperience();
                    }
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomNavigationBarJobseekerApp()),
                    );
                  },
                  child: Text(
                    confirm,
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
                    primary: Colors.black,
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
                    'Cancel !',
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
                    primary: Color(0xFFD7CDFF),
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
