import 'package:MyJob/Helper/Data.dart';
import 'package:MyJob/Models/JobPosts/JobPostModel.dart';
import 'package:MyJob/Repositories/user/User_Repository.dart';
import 'package:MyJob/employer_screens/pages/profile/ManagePosts/Widgets/JobTypeWidget.dart';
import 'package:MyJob/employer_screens/pages/profile/ManagePosts/Widgets/PhotosWidget.dart';
import 'package:MyJob/employer_screens/pages/profile/ManagePosts/Widgets/addRequiredSkills.dart';
import 'package:MyJob/employer_screens/pages/profile/ManagePosts/controller/ManagePostsController.dart';
import 'package:MyJob/employer_screens/pages/profile/ManagePosts/Widgets/JobCategoryWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class EditJobPostView extends StatefulWidget {
  final JobPostModel jobPost;

  const EditJobPostView({Key? key, required this.jobPost}) : super(key: key);

  @override
  State<EditJobPostView> createState() => _EditJobPostViewState();
}

class _EditJobPostViewState extends State<EditJobPostView> {
  final _formKey = GlobalKey<FormState>();
  late final controller;
  final userRepo = UserRepository.Instance;

  @override
  void initState() {
    super.initState();
    controller = ManagePostsController.instance;
    controller.JobtitleController.text = widget.jobPost.jobTitle;
    controller.JobCategoryController.value = widget.jobPost.JobCategory;
    controller.JobDescriptionController.text = widget.jobPost.jobDescription;
    controller.JobLocationController.text = widget.jobPost.jobLocation;
    controller.JobSalaryController.value = widget.jobPost.jobSalary;
    controller.selectedJobTypes.value = widget.jobPost.jobType;
    controller.JobRequirementController.text = widget.jobPost.Requirement;
    controller.RequiredSkills.value = widget.jobPost.RequiredSkills;
    controller.photos.value = widget.jobPost.Photos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Edit Job Post",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 21,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
            controller.photos.value = widget.jobPost.Photos;
          },
          icon: Image(
            image: AssetImage("images/left-arrow.png"),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Form(
          key: _formKey,
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Job Details Section
                Text(
                  'Job Details',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.1,
                  ), // Section header
                ),
                SizedBox(height: 15),
                Text(
                  'Job Title',
                  style: GoogleFonts.dmSans(
                    color: Color(0xFF150B3D),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: controller.JobtitleController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.10000000149011612),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(13)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(13)),
                    errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.red.withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(13)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.red.withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(13)),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a Job Title' : null,
                ),
                SizedBox(height: 10),
                Text(
                  'Job Description',
                  style: GoogleFonts.dmSans(
                    color: Color(0xFF150B3D),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: controller.JobDescriptionController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.10000000149011612),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(13)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(13)),
                    errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.red.withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(13)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.red.withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(13)),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  ),
                  maxLines: null,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a Job Description' : null,
                ),
                SizedBox(height: 10),
                Text(
                  'Job Location',
                  style: GoogleFonts.dmSans(
                    color: Color(0xFF150B3D),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.black.withOpacity(0.10000000149011612),
                  ),
                  width: MediaQuery.of(context).size.width - 50,
                  child: Row(
                    children: [
                      Icon(Iconsax.location),
                      SizedBox(width: 10),
                      DropdownButton<String>(
                        value: controller.JobLocationController.text,
                        borderRadius: BorderRadius.circular(15),
                        focusColor: Colors.white,
                        iconEnabledColor: Colors.black,
                        underline: SizedBox.shrink(),
                        items: Data.cities
                            .map((city) => DropdownMenuItem<String>(
                                  value: city,
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 150,
                                    child: FittedBox(
                                      alignment: Alignment.topLeft,
                                      fit: BoxFit.scaleDown,
                                      child: Text(city),
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            controller.JobLocationController.text = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Job Type',
                  style: GoogleFonts.dmSans(
                    color: Color(0xFF150B3D),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),

                JobTypeWidget(controller: controller),
                SizedBox(height: 20),
                Text(
                  'Job Salary (e.g \$15k/month)',
                  style: GoogleFonts.dmSans(
                    color: Color(0xFF150B3D),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),
                SfSlider(
                  value:
                      double.tryParse(controller.JobSalaryController.value) ??
                          0.0,
                  min: 0,
                  max: 50000,
                  showLabels: true,
                  shouldAlwaysShowTooltip: true,
                  numberFormat: NumberFormat.compactCurrency(
                    symbol: '\$',
                    decimalDigits: 0,
                  ),
                  onChanged: (value) {
                    controller.JobSalaryController.value = value.toString();
                  },
                ),
                // Skills & Requirements Section
                SizedBox(height: 10),
                Text(
                  'Required Skills',
                  style: GoogleFonts.dmSans(
                    color: Color(0xFF150B3D),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),
                Wrap(
                  spacing: 10,
                  children: (controller.RequiredSkills as RxList)
                      .map((skill) => Chip(
                            label: Text(skill),
                            deleteIcon: Icon(Icons.close, color: Colors.black),
                            backgroundColor: Colors.grey.shade300,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                  color: Colors.transparent), // Remove border
                            ),
                            onDeleted: () =>
                                controller.RequiredSkills.remove(skill),
                          ))
                      .toList(),
                ),
                SizedBox(height: 5),

                ElevatedButton.icon(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return addRequiredSkillsWidget(controller: controller);
                    },
                  ),
                  icon: Icon(Icons.add, color: Colors.white),
                  label:
                      Text('Add Skill', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.black,
                  ),
                ),
                SizedBox(height: 10),

                Text(
                  'Job Category',
                  style: GoogleFonts.dmSans(
                    color: Color(0xFF150B3D),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),

                JobCategoryWidget(controller: controller),
                SizedBox(height: 10),
                Text(
                  'Job Requirements',
                  style: GoogleFonts.dmSans(
                    color: Color(0xFF150B3D),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),

                TextFormField(
                  controller: controller.JobRequirementController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.10000000149011612),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(13)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(13)),
                    errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.red.withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(13)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.red.withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(13)),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  ),
                  maxLines: null, // Allow multi-line input
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter Job Requirements' : null,
                ),
                // add photos section
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Photos',
                      style: GoogleFonts.dmSans(
                        color: Color(0xFF150B3D),
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final ImagePicker _picker = ImagePicker();
                        final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery);
                        if (image != null) {
                          final imageUrl = await userRepo.uploadimage(
                              'User/Images/PostsPhotos', image);
                          controller.photos.add(imageUrl);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade200,
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: Row(
                          children: [
                            Text(
                              "Add Photo",
                              style: GoogleFonts.dmSans(
                                color: Color(0xFF150B3D),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(Icons.add_a_photo)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5),
                if (controller.photos.length != 0)
                  PhotosWidget(controller: controller),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text("Cancel"),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(vertical: 13),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 25),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            controller.editJobPost(widget.jobPost.id);
                          },
                          child: Text("Save Changes"),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 13),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
