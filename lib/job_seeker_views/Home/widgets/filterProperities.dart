import 'package:flutter/material.dart';
import 'package:MyJob/job_seeker_views/Home/Controller/JobPostController.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class filterPropertiesWidget extends StatelessWidget {
  const filterPropertiesWidget({super.key});

  String formatSalary(double salary) {
    if (salary >= 1000) {
      double formattedSalary = salary / 1000;
      return '\$${formattedSalary.toStringAsFixed(0)}k';
    } else {
      return '\$$salary';
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = JobPostController.instance;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Obx(
                  () => Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.close)),
                          Text(
                            "Filter",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20)),
                          ),
                          SizedBox(width: 15)
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // =================== last update ====================
                          Text(
                            "Last Update",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              letterSpacing: -0.5,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: Text("Recent"),
                            value: "recent",
                            activeColor: Colors.black,
                            groupValue: controller.lastUpdate.value,
                            onChanged: (value) =>
                                controller.lastUpdate.value = value!,
                          ),
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: Text("Last week"),
                            activeColor: Colors.black,
                            value: "last_week",
                            groupValue: controller.lastUpdate.value,
                            onChanged: (value) =>
                                controller.lastUpdate.value = value!,
                          ),
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            activeColor: Colors.black,
                            title: Text("Last month"),
                            value: "last_month",
                            groupValue: controller.lastUpdate.value,
                            onChanged: (value) =>
                                controller.lastUpdate.value = value!,
                          ),
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            activeColor: Colors.black,
                            splashRadius: 30.0,
                            title: Text("Any time"),
                            value: "anytime",
                            groupValue: controller.lastUpdate.value,
                            onChanged: (value) =>
                                controller.lastUpdate.value = value!,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Select Category",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              letterSpacing: -0.5,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            width: MediaQuery.of(context).size.width * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey.shade200,
                            ),
                            child: DropdownButton<String>(
                              borderRadius: BorderRadius.circular(15),
                              focusColor: Colors.white,
                              value: controller.selectedCategory.value,
                              style: TextStyle(color: Colors.white),
                              iconEnabledColor: Colors.black,
                              underline: SizedBox.shrink(),
                              isExpanded: true,
                              items: <String>[
                                'All',
                                'Computer & IT',
                                'Business & Finance',
                                'Creative & Design',
                                'Marketing',
                                'Education & Training',
                                'Engineering',
                                'Media & Communications',
                                'Healthcare',
                                'Human Services',
                                'Legal & Finance'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      letterSpacing: -0.5,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newCategory) {
                                controller.selectedCategory.value =
                                    newCategory!;
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Salary",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              letterSpacing: -0.5,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 10),
                          SfRangeSlider(
                            values: SfRangeValues(
                                controller.minSalary.value.toDouble(),
                                controller.maxSalary.value.toDouble()),
                            min: 0,
                            max: 50000,
                            onChanged: (SfRangeValues values) {
                              controller.minSalary.value = values.start.toInt();
                              controller.maxSalary.value = values.end.toInt();
                            },
                            showLabels: true,
                            stepSize: 1000,
                            shouldAlwaysShowTooltip: true,
                            numberFormat: NumberFormat.compactCurrency(
                              symbol: '\$',
                              decimalDigits: 0,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Job Type",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              letterSpacing: -0.5,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 15),

                          Wrap(
                            direction: Axis.horizontal,
                            spacing: 10,
                            runSpacing: 5,
                            children: List.generate(
                              controller.jobTypes.length,
                              (index) {
                                final jobType = controller.jobTypes[index];
                                return InkWell(
                                  onTap: () {
                                    if (controller.selectedJobTypes
                                        .contains(jobType)) {
                                      controller.selectedJobTypes
                                          .remove(jobType);
                                    } else {
                                      controller.selectedJobTypes.add(jobType);
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: controller.selectedJobTypes
                                                .contains(jobType)
                                            ? Colors.black
                                            : Colors.grey.shade200,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      jobType,
                                      style: GoogleFonts.dmSans(
                                        color: controller.selectedJobTypes
                                                .contains(jobType)
                                            ? Colors.white
                                            : Colors.black,
                                        letterSpacing: -0.5,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "City",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              letterSpacing: -0.5,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey.shade200,
                            ),
                            child: DropdownButton<String>(
                              value: controller.selectedLocation.value,
                              borderRadius: BorderRadius.circular(15),
                              focusColor: Colors.white,
                              iconEnabledColor: Colors.black,
                              underline: SizedBox.shrink(),
                              items: controller.cities
                                  .map((city) => DropdownMenuItem<String>(
                                        value: city,
                                        child: Text(city),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                controller.selectedLocation.value = value!;
                              },
                            ),
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                      SizedBox(height: 100)
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20, left: 5, right: 5),
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 50,
                        blurRadius: 30,
                        offset: Offset(0, 15),
                      ),
                    ]),
                    child: SizedBox(
                      height: 50,
                      width: 200,
                      child: FloatingActionButton(
                        backgroundColor: Colors.black,
                        onPressed: () {
                          controller.filterJobPosts();
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Apply Now",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 15,
                            letterSpacing: -0.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
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
