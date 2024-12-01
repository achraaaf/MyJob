import 'package:MyJob/Helper/Data.dart';
import 'package:flutter/material.dart';
import 'package:MyJob/job_seeker_views/Controllers/JobSeekerController.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SkillsController extends GetxController {
  static SkillsController get instance => Get.find();


  Widget iconss() {
    return Icon(Iconsax.check);
  }

  Rx<List<String>> filtredSkills = Rx<List<String>>([]);
  RxList selectedSkills = [].obs;
  final JobSeekerData = JobSeekerController.instance;

  @override
  void onInit() {
    super.onInit();
    filtredSkills.value = Data.skills;
    List skillsData = JobSeekerData.jobSeeker.value.skills;

    selectedSkills.addAll(skillsData);
  }

  void filtreSkillsList(String name) {
    List<String> result = [];

    if (name.isEmpty) {
      result = Data.skills;
    } else {
      result = Data.skills
          .where(
              (element) => element.toLowerCase().contains(name.toLowerCase()))
          .toList();
    }
    filtredSkills.value = result;
  }

  void toggleSkill(String skill) {
    if (selectedSkills.contains(skill)) {
      selectedSkills.remove(skill);
    } else {
      selectedSkills.add(skill);
    }
  }

  void addSkill(String skill) {
    if (!selectedSkills.contains(skill)) {
      selectedSkills.add(skill);
    }
  }

  void removeSkill(String skill) {
    if (selectedSkills.contains(skill)) {
      selectedSkills.remove(skill);
    }
  }

  Widget getIconForSkill(String skill) {
    if (selectedSkills.contains(skill)) {
      return Icon(Icons.check);
    } else {
      return SizedBox.shrink();
      
    }
  }
}
