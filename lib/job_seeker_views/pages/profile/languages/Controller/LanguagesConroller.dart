import 'package:flutter/material.dart';
import 'package:MyJob/job_seeker_views/Controllers/JobSeekerController.dart';
import 'package:get/get.dart';

class LanguagesConroller extends GetxController {
  static LanguagesConroller get instance => Get.find();

  final JobSeekerData = JobSeekerController.instance;

  final Map<String, String> allLanguages = {
    'Eng': 'English',
    'Fr': 'French',
    'es': 'Spanish',
    'Hindi': 'Hindi',
    'Ita': 'Italian',
    'Malaysian': 'Malaysian',
    'arabic': 'Arabic',
    'Ger': 'German',
    'Indo': 'Indonesian',
    'Japan': 'Japanese',
  };

  final RxList<String> filteredLanguages = <String>[].obs;
  final RxList selectedLanguage = [].obs;

  @override
  void onInit() {
    filteredLanguages.value = allLanguages.values.toList();

    final List LanguagesData = JobSeekerData.jobSeeker.value.Languages;
    selectedLanguage.addAll(LanguagesData);

    super.onInit();
  }

  void filterLanguages(String searchText) {
    filteredLanguages.value = allLanguages.entries
        .where((entry) =>
            entry.value.toLowerCase().contains(searchText.toLowerCase()))
        .map((entry) => entry.value)
        .toList();
  }

  void toggleLanguage(String language) {
    if (selectedLanguage.contains(language)) {
      selectedLanguage.remove(language);
    } else {
      selectedLanguage.add(language);
    }
  }

  void addLanguage(String language) {
    if (!selectedLanguage.contains(language)) {
      selectedLanguage.add(language);
    }
  }

  void removeLanguage(String language) {
    if (selectedLanguage.contains(language)) {
      selectedLanguage.remove(language);
    }
  }

  Widget getIconForSkill(String language) {
    if (selectedLanguage.contains(language)) {
      return Icon(Icons.check);
    } else {
      return SizedBox.shrink();
    }
  }
}
