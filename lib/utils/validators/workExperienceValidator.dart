class workExperienceValidator {
  
  static String? JobTitleValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter job title';
    }
    return null;
  }

  static String? CompanyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'please enter company name';
    }
    return null;
  }

  static String? StartDateValidato(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter start date';
    }
    return null;
  }

  static String? EndDateValidato(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter end date';
    }
    return null;
  }

}