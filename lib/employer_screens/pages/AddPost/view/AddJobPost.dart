import 'package:MyJob/Helper/Data.dart';
import 'package:MyJob/Repositories/user/User_Repository.dart';
import 'package:MyJob/employer_screens/pages/AddPost/controller/AddPostController.dart';
import 'package:MyJob/employer_screens/pages/profile/ManagePosts/Widgets/PhotosWidget.dart';
import 'package:MyJob/employer_screens/pages/profile/ManagePosts/Widgets/addRequiredSkills.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class Add_Post extends StatefulWidget {
  const Add_Post({super.key});

  @override
  State<Add_Post> createState() => _Add_PostState();
}

class _Add_PostState extends State<Add_Post> {
  final Map<String, IconData> jobTypeIcons = {
    'Full-time': Icons.sunny,
    'Part-time': Iconsax.clock,
    'Internship': Iconsax.book,
    'Temporary': Iconsax.calendar,
    'Freelance': Iconsax.briefcase,
  };

  final Map<String, String> jobTypeDesciption = {
    'Full-time': 'Horaires standards',
    'Part-time': 'Horaires flexibles',
    'Internship': 'Expérience d\'apprentissage',
    'Temporary': 'Durée limitée',
    'Freelance': 'Travail indépendant',
  };

  final controller = Get.put(AddPostController());
  final userRepo = UserRepository.Instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Ajouter une publication",
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
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Obx(() {
            if (controller.isLoading.value)
              return SizedBox(
                width: 500,
                height: 500,
                child: Lottie.asset("images/getting.json"),
              );
            return Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ajouter une publication de travail',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.1,
                    ), // Section header
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Titre du poste',
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
                          EdgeInsets.symmetric(vertical: 13, horizontal: 15),
                    ),
                    validator: (value) => value!.isEmpty
                        ? 'Veuillez entrer un titre de poste'
                        : null,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Description du poste',
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
                          EdgeInsets.symmetric(vertical: 13, horizontal: 15),
                    ),
                    maxLines: null,
                    validator: (value) => value!.isEmpty
                        ? 'Veuillez entrer une description de poste'
                        : null,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Lieu de travail',
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
                          value: controller.JobLocationController.value,
                          hint: Text(
                            "Choisir un lieu",
                            style: GoogleFonts.dmSans(
                              color: Color(0xFF150B3D),
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(15),
                          focusColor: Colors.white,
                          iconEnabledColor: Colors.black,
                          underline: SizedBox.shrink(),
                          items: Data.cities
                              .map((city) => DropdownMenuItem<String>(
                                    value: city,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          150,
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
                              controller.JobLocationController.value = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Choisir un type de poste',
                    style: GoogleFonts.dmSans(
                      color: Color(0xFF150B3D),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: (controller.jobTypes)
                        .map((jobType) => InkWell(
                              onTap: () {
                                if (controller.selectedJobTypes
                                    .contains(jobType)) {
                                  controller.selectedJobTypes.remove(jobType);
                                } else {
                                  controller.selectedJobTypes.add(jobType);
                                }
                              },
                              child: Container(
                                height: 120,
                                width: 110,
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: controller.selectedJobTypes
                                          .contains(jobType)
                                      ? Colors.black
                                      : Colors.white,
                                  border: Border.all(
                                    color: Colors.grey.shade400,
                                    width: 0.5,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      jobTypeIcons[jobType] ?? Icons.error,
                                      color: controller.selectedJobTypes
                                              .contains(jobType)
                                          ? Colors.white
                                          : Colors.black,
                                      size: 24.0,
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      jobType,
                                      style: GoogleFonts.dmSans(
                                        color: controller.selectedJobTypes
                                                .contains(jobType)
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      jobTypeDesciption[jobType] ?? '',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.dmSans(
                                        color: controller.selectedJobTypes
                                                .contains(jobType)
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Salaire du poste (ex. 15k€/mois)',
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
                      symbol: '€',
                      decimalDigits: 0,
                    ),
                    onChanged: (value) {
                      controller.JobSalaryController.value =
                          value.round().toString();
                    },
                  ),
                  // Section Compétences & Exigences
                  SizedBox(height: 10),
                  Text(
                    'Compétences requises',
                    style: GoogleFonts.dmSans(
                      color: Color(0xFF150B3D),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 5),

                  Wrap(
                    spacing: 10,
                    // ignore: unnecessary_cast
                    children: (controller.RequiredSkills as RxList)
                        .map((skill) => Chip(
                              label: Text(skill),
                              deleteIcon:
                                  Icon(Icons.close, color: Colors.black),
                              backgroundColor: Colors.grey.shade300,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Colors.transparent),
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
                    label: Text('Ajouter une compétence',
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),

                  Text(
                    'Catégorie de poste',
                    style: GoogleFonts.dmSans(
                      color: Color(0xFF150B3D),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 5),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey.shade200,
                    ),
                    child: Row(
                      children: [
                        Icon(Iconsax.briefcase),
                        SizedBox(width: 10),
                        Expanded(
                          child: DropdownButton<String>(
                            borderRadius: BorderRadius.circular(15),
                            focusColor: Colors.white,
                            value: controller.JobCategoryController.value,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor: Colors.black,
                            underline: SizedBox.shrink(),
                            hint: Text(
                              "choisir une catégorie",
                              style: GoogleFonts.dmSans(
                                color: Color(0xFF150B3D),
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            isExpanded: true,
                            items: <String>[
                              'Informatique & IT',
                              'Affaires & Finance',
                              'Créatif & Design',
                              'Marketing',
                              'Éducation & Formation',
                              'Ingénierie',
                              'Médias & Communications',
                              'Soins de santé',
                              'Services sociaux',
                              'Juridique & Finance'
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
                              controller.JobCategoryController.value =
                                  newCategory!;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Exigences du poste',
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
                    maxLines: null,
                    validator: (value) => value!.isEmpty
                        ? 'Veuillez entrer les exigences du poste'
                        : null,
                  ),
                  // Section Ajouter des photos
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
                                "Ajouter une photo",
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
                        SizedBox(width: 50),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              controller.addJobPost();
                            },
                            child: Text("Ajouter la publication"),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 13),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                )),
                          ),
                        ),
                        SizedBox(width: 50),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
