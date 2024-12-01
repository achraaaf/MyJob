import 'package:MyJob/Authentication/EmployerSetup/SetupController/SetupController.dart';
import 'package:MyJob/Helper/Data.dart';
import 'package:MyJob/employer_screens/Employer_Home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class SetupView extends StatelessWidget {
  SetupView({super.key});

  final controller = Get.put(SetupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Text(
                  "1 of 2",
                  style: TextStyle(
                    fontFamily: 'Satoshi',
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Center(
                        child: Text(
                          "Set up your account",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "This quick setup process will help us personalize your experience and connect you with relevant features. By completing these steps, you'll gain access to exclusive content, personalized recommendations, and a smoother user journey. Let's get started!.",
                        style: TextStyle(
                          fontFamily: 'Satoshi',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        "Select Industry",
                        style: TextStyle(
                          fontFamily: 'Satoshi',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.black.withOpacity(0.10000000149011612),
                        ),
                        child: Row(
                          children: [
                            Icon(Iconsax.brifecase_tick),
                            SizedBox(width: 10),
                            DropdownButton<String>(
                              value: controller.SelectedIndustry.value,
                              borderRadius: BorderRadius.circular(15),
                              focusColor: Colors.white,
                              iconEnabledColor: Colors.black,
                              underline: SizedBox.shrink(),
                              items: Data.Industries.map(
                                (industry) => DropdownMenuItem<String>(
                                  value: industry,
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 130,
                                    child: FittedBox(
                                      alignment: Alignment.topLeft,
                                      fit: BoxFit.scaleDown,
                                      child: Text(industry),
                                    ),
                                  ),
                                ),
                              ).toList(),
                              onChanged: (value) {
                                controller.SelectedIndustry.value = value!;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        "Select Company Size",
                        style: TextStyle(
                          fontFamily: 'Satoshi',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.black.withOpacity(0.10000000149011612),
                        ),
                        width: 280,
                        child: Row(
                          children: [
                            Icon(Iconsax.building),
                            SizedBox(width: 10),
                            DropdownButton<String>(
                              value: controller.SelectedCCompanySize.value,
                              borderRadius: BorderRadius.circular(15),
                              focusColor: Colors.white,
                              iconEnabledColor: Colors.black,
                              underline: SizedBox.shrink(),
                              items: <String>[
                                '1 - 10 Employees',
                                '10 - 50 Employees',
                                '50 - 100 Employees',
                                '100 - 500 Employees',
                                '500 - 1000 Employees',
                                '+1000 Employees',
                              ]
                                  .map(
                                    (industry) => DropdownMenuItem<String>(
                                      value: industry,
                                      child: Text(industry),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                controller.SelectedCCompanySize.value = value!;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => AboutCompanyPage());
                          },
                          child: Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Satoshi',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 10)),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AboutCompanyPage extends StatelessWidget {
  AboutCompanyPage({super.key});

  final controller = SetupController.instance;

  TextEditingController aboutCompanyController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Text(
                  "2 of 2",
                  style: TextStyle(
                    fontFamily: 'Satoshi',
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "About Company",
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Text(
                        "About company",
                        style: GoogleFonts.poppins(
                          color: Color(0xFF150B3D),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 73, 73, 73)
                              .withOpacity(0.10000000149011612),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                        child: TextFormField(
                          controller: aboutCompanyController,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          maxLength: 175,
                          maxLines: null,
                          // ignore: body_might_complete_normally_nullable
                          validator: (Value) {
                            if (Value!.isEmpty) {
                              return 'Please enter your company';
                            }
                          },
                          onChanged: (value) {
                            controller.description.value = value;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 7, left: 20),
                            hintText: 'Tell us about your company',
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
                          height: 55,
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: ElevatedButton(
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              controller.storeData();
                              Get.off(() => employer_HomeScreen());
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
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
