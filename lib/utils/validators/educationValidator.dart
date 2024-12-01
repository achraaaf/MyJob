class educationValidator {
  static String? LevelOfEducationValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Level of Education is required";
    }
    return null;
  }

  static String? InstitutionNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Institution Name is required";
    }
    return null;
  }

  static String? FieldOfStudy(String? value) {
    if (value == null || value.isEmpty) {
      return "Field of Study is required";
    }
    return null;
  }

  static String? StartDateValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Start Date is required";
    }
    return null;
  }

  static String? EndDateValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "End Date is required";
    }
    return null;
  }
}
